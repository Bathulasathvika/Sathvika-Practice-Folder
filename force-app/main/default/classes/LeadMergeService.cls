public class LeadMergeService {

    public static Set<Id> mergeDuplicates(Set<Id> leadIds) {
        Set<Id> survivingIds = new Set<Id>();

        if (leadIds == null || leadIds.isEmpty()) {
            return survivingIds;
        }

        survivingIds.addAll(leadIds);

        List<Lead> incomingLeads = [
            SELECT Id, Email, Phone
            FROM Lead
            WHERE Id IN :leadIds
            AND IsConverted = false
            AND Email != null
            AND Phone != null
        ];

        if (incomingLeads.isEmpty()) {
            return survivingIds;
        }

        Set<String> emails = new Set<String>();
        Set<String> phones = new Set<String>();

        for (Lead ld : incomingLeads) {
            emails.add(ld.Email.trim());
            phones.add(ld.Phone.trim());
        }

        List<Lead> candidates = [
            SELECT Id, FirstName, LastName, Email, Phone,
                   Company, Title, Website
            FROM Lead
            WHERE IsConverted = false
            AND Email IN :emails
            AND Phone IN :phones

        ];

        Map<String, List<Lead>> groups =
            new Map<String, List<Lead>>();

        for (Lead candidate : candidates) {
            for (Lead incoming : incomingLeads) {
                if (
                    candidate.Email != null &&
                    candidate.Phone != null &&
                    candidate.Email.trim().equalsIgnoreCase(
                        incoming.Email.trim()
                    ) &&
                    candidate.Phone.trim() == incoming.Phone.trim()
                ) {
                    String key = candidate.Email.trim().toLowerCase()
                        + '|' + candidate.Phone.trim();

                    if (!groups.containsKey(key)) {
                        groups.put(key, new List<Lead>());
                    }

                    // Avoid adding the same record more than once.
                    Boolean alreadyAdded = false;

                    for (Lead existing : groups.get(key)) {
                        if (existing.Id == candidate.Id) {
                            alreadyAdded = true;
                            break;
                        }
                    }

                    if (!alreadyAdded) {
                        groups.get(key).add(candidate);
                    }

                    break;
                }
            }
        }

        Map<Id, Lead> mastersToUpdate = new Map<Id, Lead>();
        Map<Id, List<Lead>> duplicatesByMaster =
            new Map<Id, List<Lead>>();

        for (String key : groups.keySet()) {
            List<Lead> groupLeads = groups.get(key);

            if (groupLeads.size() < 2) {
                continue;
            }

            // Candidates are ordered oldest first.
            Lead master = groupLeads[0];
            List<Lead> duplicates = new List<Lead>();

            for (Integer i = 1; i < groupLeads.size(); i++) {
                Lead duplicate = groupLeads[i];

                if (String.isBlank(master.FirstName)) {
                    master.FirstName = duplicate.FirstName;
                }

                if (String.isBlank(master.LastName)) {
                    master.LastName = duplicate.LastName;
                }

                if (String.isBlank(master.Company)) {
                    master.Company = duplicate.Company;
                }

                if (String.isBlank(master.Title)) {
                    master.Title = duplicate.Title;
                }

                if (String.isBlank(master.Website)) {
                    master.Website = duplicate.Website;
                }

                duplicates.add(duplicate);
            }

            if (!duplicates.isEmpty()) {
                mastersToUpdate.put(master.Id, master);
                duplicatesByMaster.put(master.Id, duplicates);
            }
        }

        if (duplicatesByMaster.isEmpty()) {
            System.debug('No duplicate Leads found.');
            return survivingIds;
        }

        // Update master fields in one DML operation.
        List<Lead> masterList = mastersToUpdate.values();

        Database.SaveResult[] updateResults =
            Database.update(masterList, false);

        Set<Id> validMasterIds = new Set<Id>();

        for (Integer i = 0; i < updateResults.size(); i++) {
            if (updateResults[i].isSuccess()) {
                validMasterIds.add(masterList[i].Id);
            } else {
                for (Database.Error err :
                     updateResults[i].getErrors()) {
                    System.debug(
                        LoggingLevel.ERROR,
                        'Master update failed: ' + err.getMessage()
                    );
                }
            }
        }

        // Merge at most two duplicate records per call.
        for (Id masterId : duplicatesByMaster.keySet()) {
            if (!validMasterIds.contains(masterId)) {
                continue;
            }

            Lead master = mastersToUpdate.get(masterId);
            List<Lead> duplicates = duplicatesByMaster.get(masterId);

            for (Integer i = 0; i < duplicates.size(); i += 2) {
                List<Lead> mergeGroup = new List<Lead>();
                mergeGroup.add(duplicates[i]);

                if (i + 1 < duplicates.size()) {
                    mergeGroup.add(duplicates[i + 1]);
                }

                List<Database.MergeResult> results =
                    Database.merge(master, mergeGroup, false);

                for (Integer j = 0; j < results.size(); j++) {
                    Database.MergeResult result = results[j];
                    Lead duplicate = mergeGroup[j];

                    if (result.isSuccess()) {
                        survivingIds.remove(duplicate.Id);

                        System.debug(
                            'Successfully merged Lead ' + duplicate.Id +
                            ' into master ' + masterId
                        );
                    } else {
                        for (Database.Error err : result.getErrors()) {
                            System.debug(
                                LoggingLevel.ERROR,
                                'Merge failed for Lead ' + duplicate.Id +
                                ': ' + err.getMessage()
                            );
                        }
                    }
                }
            }
        }

        return survivingIds;
    }
}

