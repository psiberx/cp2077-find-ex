@addField(ScriptableDataView)
public let m_searchTerm: String;

@addMethod(ScriptableDataView)
public func SetSearchTerm(term: String) {
    this.m_searchTerm = UTF8StrUpper(term);

    this.Filter();
}
