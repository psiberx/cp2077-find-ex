import FindEx.*
import Codeware.UI.*

@addField(VirtualNestedListController)
protected let m_dataLevels: array<Int32>;

@addField(VirtualNestedListController)
protected let m_scrollController: wref<inkScrollController>;

@wrapMethod(VirtualNestedListController)
protected cb func OnInitialize() {
    wrappedMethod();

    this.m_scrollController = inkWidgetHelper.GetClosestControllerByType(this.GetRootWidget(), n"inkScrollController") as inkScrollController;
}

@wrapMethod(VirtualNestedListController)
public func SetData(const data: script_ref<array<ref<VirutalNestedListData>>>, opt keepToggledLevels: Bool, opt sortOnce: Bool) {
    wrappedMethod(data, keepToggledLevels, sortOnce);

    ArrayClear(this.m_dataLevels);

    let i = 0;
    let count = ArraySize(Deref(data));
    while i < count {
        let level = Deref(data)[i].m_level;
        if !ArrayContains(this.m_dataLevels, level) {
            ArrayPush(this.m_dataLevels, level);
        }
        i += 1;
    }
}

@addMethod(VirtualNestedListController)
public func SetSearchTerm(term: String) {
    this.ToggleAll(false);
    
    this.m_dataView.SetSearchTerm(term);
}

@wrapMethod(VirtualNestedListController)
public func ToggleLevel(targetLevel: Int32) {
    wrappedMethod(targetLevel);

    this.FixScrollPosition();
}

@addMethod(VirtualNestedListController)
public func ToggleAll(collapse: Bool) {
    if this.m_dataView.CanToggleLevels() {
        if NotEquals(collapse, this.m_defaultCollapsed) {
            this.m_toggledLevels = this.m_dataLevels;
        } else {
            ArrayClear(this.m_toggledLevels);
        }

        this.m_dataView.SetToggledLevels(this.m_toggledLevels, this.m_defaultCollapsed);
        this.FixScrollPosition();
    }
}

@addMethod(VirtualNestedListController)
protected cb func FixScrollPosition() {
    if IsDefined(this.m_scrollController) {
        GameInstance.GetDelaySystem(GetGameInstance()).DelayCallbackNextFrame(FixScrollPositionCallback.Create(this.m_scrollController));
    }
}
