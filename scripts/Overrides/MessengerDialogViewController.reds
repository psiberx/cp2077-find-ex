@addField(MessengerDialogViewController)
public let m_searchTerm: String;

@addMethod(MessengerDialogViewController)
public func SetSearchTerm(term: String) {
    this.m_searchTerm = UTF8StrUpper(term);
    this.UpdateData();
}

@wrapMethod(MessengerDialogViewController)
private final func SetVisited(records: array<wref<JournalEntry>>) {
    if UTF8StrLen(this.m_searchTerm) != 0 {
        ArrayClear(this.m_replyOptions);
        
        let messages: array<wref<JournalEntry>>;

        for journalEntry in this.m_messages {
            let messageEntry = journalEntry as JournalPhoneMessage;
            if StrContains(UTF8StrUpper(GetLocalizedText(messageEntry.GetText())), this.m_searchTerm) {
                ArrayPush(messages, journalEntry);
            }
        }

        if ArraySize(messages) != 0 {
            this.m_messages = messages;
            return;
        }
    }
    
    wrappedMethod(records);
}
