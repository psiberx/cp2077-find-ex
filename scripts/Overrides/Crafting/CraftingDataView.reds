@wrapMethod(CraftingDataView)
public func FilterItem(data: ref<IScriptable>) -> Bool {
    if !wrappedMethod(data) {
        return false;
    }

    if UTF8StrLen(this.m_searchTerm) == 0 {
        return true;
    }

    let recipeData = data as RecipeData;

    if !IsDefined(recipeData) {
        return true;
    }

    return StrContains(UTF8StrUpper(recipeData.label), this.m_searchTerm);
    // || StrContains(UTF8StrUpper(recipeData.description), this.m_searchTerm);
}
