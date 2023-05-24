@addField(MessengerContactDataView)
protected let m_disableTextFilter: Bool;

@addMethod(MessengerContactDataView)
protected func PreFilter() {
    this.m_disableTextFilter = true;

    if UTF8StrLen(this.m_searchTerm) == 0 {
        return;
    }
    
    this.Filter();
    this.m_disableTextFilter = false;

    let journal = GameInstance.GetJournalManager(GetGameInstance());
    let groups: array<wref<VirutalNestedListData>>;
    let visibleLevels: array<Int32>;

    let i = 0u;
    let size = this.Size();

    while i < size {
        let itemData = this.GetItem(i) as VirutalNestedListData;
        let contactData = itemData.m_data as ContactData;
        
        if itemData.m_collapsable {
            // Case: MessengerContactType.Group
            ArrayPush(groups, itemData);
        } else {
            contactData.matchesSearchTerm = false;

            let journalEntry = journal.GetEntry(Cast<Uint32>(contactData.hash));
            let messageEntries: array<wref<JournalEntry>>;
            let replyEntries: array<wref<JournalEntry>>;

            if itemData.m_widgetType == 1u {
                // Case: MessengerContactType.Thread
                let conversationEntry = journalEntry as JournalPhoneConversation;
                if StrContains(UTF8StrUpper(GetLocalizedText(conversationEntry.GetTitle())), this.m_searchTerm) {
                    contactData.matchesSearchTerm = true;
                } else {
                    journal.GetMessagesAndChoices(conversationEntry, messageEntries, replyEntries);
                }
            } else {
                // Case: MessengerContactType.Contact
                let contactEntry = journalEntry as JournalContact;
                if StrContains(UTF8StrUpper(contactEntry.GetLocalizedName(journal)), this.m_searchTerm) {
                    contactData.matchesSearchTerm = true;
                } else {
                    journal.GetFlattenedMessagesAndChoices(contactEntry, messageEntries, replyEntries);
                }
            }

            for messageEntry in messageEntries {
                if StrContains(UTF8StrUpper(GetLocalizedText((messageEntry as JournalPhoneMessage).GetText())), this.m_searchTerm) {
                    contactData.matchesSearchTerm = true;
                    break;
                }
            }

            if contactData.matchesSearchTerm {
                if !ArrayContains(visibleLevels, itemData.m_level) {
                    ArrayPush(visibleLevels, itemData.m_level);
                }
            }
        }

        i += 1u;
    }

    for itemData in groups {
        (itemData.m_data as ContactData).matchesSearchTerm = ArrayContains(visibleLevels, itemData.m_level);
    }
}

@addMethod(MessengerContactDataView)
protected func FilterText(data: ref<VirutalNestedListData>) -> Bool {
    return this.m_disableTextFilter || (data.m_data as ContactData).matchesSearchTerm;
}
