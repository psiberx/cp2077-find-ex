import FindEx.*
import Codeware.UI.*

@wrapMethod(ShardsMenuGameController)
protected cb func OnInitialize() -> Bool {
    wrappedMethod();

    let panel = this.GetChildWidgetByPath(n"list_wrapper") as inkCanvas;

    let addon = NestedListControlAddon.Create();
    addon.SetMargin(634.0, -95.0);
    addon.Reparent(panel, this);
}

@addMethod(ShardsMenuGameController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_listController.SetSearchTerm(evt.term);
}

@addMethod(ShardsMenuGameController)
protected cb func OnCollapseClick(evt: ref<CollapseClick>) -> Bool {
    if evt.action.IsAction(n"click") {
        this.m_listController.ToggleAll(evt.collapse);
    }
}
