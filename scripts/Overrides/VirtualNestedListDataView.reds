@addField(VirtualNestedListDataView)
public let m_searchTerm: String;

@addMethod(VirtualNestedListDataView)
public func CanToggleLevels() -> Bool {
    return UTF8StrLen(this.m_searchTerm) == 0;
}

@addMethod(VirtualNestedListDataView)
public func SetSearchTerm(term: String) {
    this.m_searchTerm = UTF8StrUpper(term);

    this.PreFilter();
    this.Filter();
    this.EnableSorting();
    this.Sort();
    this.DisableSorting();
}

@addMethod(VirtualNestedListDataView)
protected func PreFilter() {}

@wrapMethod(VirtualNestedListDataView)
private func FilterItem(data: ref<IScriptable>) -> Bool {
    if !wrappedMethod(data) {
        return false;
    }

    if UTF8StrLen(this.m_searchTerm) == 0 {
        return true;
    }

    return this.FilterText(data as VirutalNestedListData);
}

@addMethod(VirtualNestedListDataView)
protected func FilterText(data: ref<VirutalNestedListData>) -> Bool {
    return true;
}
