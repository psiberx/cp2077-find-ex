import FindEx.*
import Codeware.UI.*

@wrapMethod(CraftingLogicController)
public func Init(gameController: wref<CraftingMainGameController>) {
    wrappedMethod(gameController);

    let panel = this.GetRootCompoundWidget(); //inkWidgetRef.Get(this.m_sortingButton).parentWidget as inkCompoundWidget;

    let addon = ListControlAddon.Create();
    addon.SetMargin(0, 110.0);
    addon.Reparent(panel, gameController);
}

@addMethod(CraftingLogicController)
protected cb func OnSearchInput(evt: ref<SearchInput>) -> Bool {
    this.m_dataView.SetSearchTerm(evt.term);
}
