import FindEx.*
import Codeware.UI.*

@wrapMethod(CodexGameController)
protected cb func OnInitialize() -> Bool {
    wrappedMethod();

    // wrapper/layout_wrapper/LeftBlock/LeftBlockWrapper/CategoryContainer
    let panel = inkWidgetRef.Get(this.m_filtersContainer) as inkHorizontalPanel;

    let addon = NestedListControlAddon.Create();
    addon.SetMargin(20.0);
    addon.Reparent(panel, this);
}

@addMethod(CodexGameController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_listController.SetSearchTerm(evt.term);
}

@addMethod(CodexGameController)
protected cb func OnCollapseClick(evt: ref<CollapseClick>) -> Bool {
    if evt.action.IsAction(n"click") {
        this.m_listController.ToggleAll(evt.collapse);
    }
}
