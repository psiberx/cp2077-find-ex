import FindEx.*
import Codeware.UI.*

@wrapMethod(CraftingLogicController)
public func Init(gameController: wref<CraftingMainGameController>) {
    wrappedMethod(gameController);

    let panel = this.GetRootCompoundWidget();

    let addon = ListControlAddon.Create();
    addon.SetMargin(1060.0, 20.0);
    addon.SetWidth(315.0);
    addon.Reparent(panel, gameController);
}

@addMethod(CraftingLogicController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_dataView.SetSearchTerm(evt.term);
}
