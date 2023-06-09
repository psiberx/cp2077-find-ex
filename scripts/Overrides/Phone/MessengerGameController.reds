import FindEx.*
import Codeware.UI.*

@wrapMethod(MessengerGameController)
protected cb func OnInitialize() -> Bool {
    wrappedMethod();

    let panel = this.GetRootCompoundWidget();

    let addon = NestedListControlAddon.Create();
    addon.SetMargin(830.0, 296.0);
    addon.Reparent(panel, this);
}

@addMethod(MessengerGameController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_listController.SetSearchTerm(evt.term);
    this.m_dialogController.SetSearchTerm(evt.term);
}

@addMethod(MessengerGameController)
protected cb func OnCollapseClick(evt: ref<CollapseClick>) -> Bool {
    if evt.action.IsAction(n"click") {
        this.m_listController.ToggleAll(evt.collapse);
    }
}
