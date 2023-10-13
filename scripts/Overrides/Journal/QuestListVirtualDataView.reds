@wrapMethod(QuestListVirtualDataView)
public func FilterItem(data: ref<IScriptable>) -> Bool {
    if !wrappedMethod(data) {
        return false;
    }

    if UTF8StrLen(this.m_searchTerm) == 0 {
        return true;
    }

    let questData = data as QuestListItemData;

    if !IsDefined(questData) {
        return true;
    }

    let questEntry = questData.m_questData;

    let title = GetLocalizedText(questEntry.GetTitle(questData.m_journalManager));
    if StrContains(UTF8StrUpper(title), this.m_searchTerm) {
        return true;
    }

    let stateFilter: JournalRequestStateFilter;
    stateFilter.active = true;
    stateFilter.inactive = true;
    stateFilter.succeeded = true;
    stateFilter.failed = true;

    let children: array<wref<JournalEntry>>;
    QuestLogUtils.UnpackRecursiveWithFilter(questData.m_journalManager, questData.m_questData, stateFilter, children, true);

    for child in children {
        let objectiveEntry = child as JournalQuestObjective;
        if IsDefined(objectiveEntry) {
            if StrContains(UTF8StrUpper(GetLocalizedText(objectiveEntry.GetDescription())), this.m_searchTerm) {
                return true;
            }
        } else {
            let descEntry = child as JournalQuestDescription;
            if IsDefined(descEntry) {
                if StrContains(UTF8StrUpper(GetLocalizedText(descEntry.GetDescription())), this.m_searchTerm) {
                    return true;
                }
            } else {
                // let codexLink = child as JournalQuestCodexLink;
                // if IsDefined(codexLink) {
                //     let codexEntry = questData.m_journalManager.GetEntry(codexLink.GetLinkPathHash()) as JournalCodexEntry;
                //     if StrContains(UTF8StrUpper(GetLocalizedText(codexEntry.GetTitle())), this.m_searchTerm) {
                //         return true;
                //     }
                // }
            }
        }
    }

    return false;
}
