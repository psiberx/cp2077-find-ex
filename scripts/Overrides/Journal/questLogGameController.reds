import FindEx.*
import Codeware.UI.*

@wrapMethod(questLogGameController)
protected cb func OnInitialize() -> Bool {
    wrappedMethod();

    let panel = this.GetChildWidgetByPath(n"quests_list") as inkCanvas;

    let addon = NestedListControlAddon.Create();
    addon.SetMargin(550.0, -110.0);
    addon.Reparent(panel, this);
}

@addMethod(questLogGameController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    let listController = inkWidgetRef.GetController(this.m_virtualList) as QuestListVirtualNestedListController;
    listController.SetSearchTerm(evt.term);
}

@addMethod(questLogGameController)
protected cb func OnCollapseClick(evt: ref<CollapseClick>) -> Bool {
    if evt.action.IsAction(n"click") {
        let listController = inkWidgetRef.GetController(this.m_virtualList) as QuestListVirtualNestedListController;
        listController.ToggleAll(evt.collapse);
    }
}
