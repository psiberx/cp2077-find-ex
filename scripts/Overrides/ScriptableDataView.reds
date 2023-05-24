@addField(ScriptableDataView)
public let m_searchTerm: String;

@addMethod(ScriptableDataView)
public func SetSearchTerm(term: String) {
    this.m_searchTerm = UTF8StrUpper(term);

    this.Filter();
}

@wrapMethod(ScriptableDataView)
public func FilterItem(data: ref<IScriptable>) -> Bool {
    if !wrappedMethod(data) {
        return false;
    }

    if UTF8StrLen(this.m_searchTerm) == 0 {
        return true;
    }

    return this.FilterText(data);
}

@addMethod(ScriptableDataView)
public func FilterText(data: ref<IScriptable>) -> Bool {
    return true;
}
