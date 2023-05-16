@addMethod(ShardsNestedListDataView)
protected func FilterText(data: ref<VirutalNestedListData>) -> Bool {
    if data.m_isHeader {
        return false;
    }

    let shardEntry = data.m_data as ShardEntryData;

    return StrContains(UTF8StrUpper(GetLocalizedText(shardEntry.m_title)), this.m_searchTerm)
        || StrContains(UTF8StrUpper(GetLocalizedText(shardEntry.m_description)), this.m_searchTerm);
}
