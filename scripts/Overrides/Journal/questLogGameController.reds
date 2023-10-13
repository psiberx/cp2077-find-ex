import FindEx.*
import Codeware.UI.*

@wrapMethod(questLogGameController)
protected cb func OnInitialize() -> Bool {
    wrappedMethod();

    let panel = this.GetChildWidgetByPath(n"quests_list") as inkCanvas;

    let addon = ListControlAddon.Create();
    addon.SetMargin(1052.0, 5.0);
    addon.Reparent(panel, this);
}

@addMethod(questLogGameController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_virtualListController.m_dataView.SetSearchTerm(evt.term);
}
