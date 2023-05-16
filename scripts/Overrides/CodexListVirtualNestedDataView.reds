@addMethod(CodexListVirtualNestedDataView)
protected func FilterText(data: ref<VirutalNestedListData>) -> Bool {
    if data.m_isHeader {
        return false;
    }

    let codexEntry = data.m_data as CodexEntryData;

    return StrContains(UTF8StrUpper(GetLocalizedText(codexEntry.m_title)), this.m_searchTerm)
        || StrContains(UTF8StrUpper(GetLocalizedText(codexEntry.m_description)), this.m_searchTerm);
}
