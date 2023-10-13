module FindEx
import Codeware.UI.*

public class SearchInput extends Event {
    public let term: String;
}

public class ListControlAddon extends inkCustomController {
    protected let m_root: wref<inkHorizontalPanel>;
    protected let m_searchInput: wref<HubTextInput>;

    protected let m_delaySystem: wref<DelaySystem>;
    protected let m_searchEventCallback: ref<DelayCallback>;
    protected let m_searchEventDelayID: DelayID;

    protected cb func OnCreate() {
        let root = new inkHorizontalPanel();
        //root.SetAnchor(inkEAnchor.TopRight);
        //root.SetAnchorPoint(new Vector2(1.0, 0.0));
        //root.SetMargin(new inkMargin(0.0, 0.0, 10.0, 0));

        let input = HubTextInput.Create();
        input.SetLetterCase(textLetterCase.UpperCase);
        input.SetDefaultText(GetLocalizedText("LocKey#48662"));
        input.RegisterToCallback(n"OnInput", this, n"OnSearchInput");
        input.SetWidth(450.0);
        input.Reparent(root);
        
        this.m_root = root;
        this.m_searchInput = input;

        this.SetRootWidget(root);
    }

    protected cb func OnInitialize() {
        this.m_delaySystem = GameInstance.GetDelaySystem(this.GetGame());
        this.m_searchEventCallback = SearchInputCallback.Create(this);

        this.RegisterToGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalInput");
    }

    protected cb func OnUninitialize() {
        this.UnregisterFromGlobalInputCallback(n"OnPostOnRelease", this, n"OnGlobalInput");
    }

    protected cb func OnGlobalInput(evt: ref<inkPointerEvent>) {
        if evt.IsAction(n"mouse_left") {
            if !IsDefined(evt.GetTarget()) || !evt.GetTarget().CanSupportFocus() {
                this.GetGameController().RequestSetFocus(null);
            }
        }
    }

    protected cb func OnSearchInput(widget: wref<inkWidget>) {
        this.m_delaySystem.CancelCallback(this.m_searchEventDelayID);
        this.m_searchEventDelayID = this.m_delaySystem.DelayCallback(this.m_searchEventCallback, 0.25, false);
    }

    protected func TriggerSearchEvent() {
        let evt = new SearchInput();
        evt.term = this.m_searchInput.GetText();

        this.QueueEvent(evt);
    }

    public func SetWidth(width: Float) {
        this.m_searchInput.SetWidth(width);
    }

    public func SetMargin(left: Float, opt top: Float, opt right: Float, opt bottom: Float) {
        this.m_root.SetMargin(new inkMargin(left, top, right, bottom));
    }

    public func SetAnchor(anchor: inkEAnchor) {
        let point: Vector2;

        switch anchor {
            case inkEAnchor.TopRight:
            case inkEAnchor.CenterRight:
            case inkEAnchor.BottomRight:
                point.X = 1.0;
                break;
            case inkEAnchor.TopCenter:
            case inkEAnchor.Centered:
            case inkEAnchor.BottomCenter:
                point.X = 0.5;
                break;
        }

        switch anchor {
            case inkEAnchor.BottomLeft:
            case inkEAnchor.BottomCenter:
            case inkEAnchor.BottomRight:
                point.Y = 1.0;
                break;
            case inkEAnchor.CenterLeft:
            case inkEAnchor.Centered:
            case inkEAnchor.CenterRight:
                point.Y = 0.5;
                break;
        }

        this.m_root.SetAnchor(anchor);
        this.m_root.SetAnchorPoint(point);
    }

    public static func Create() -> ref<ListControlAddon> {
        let self = new ListControlAddon();
        self.CreateInstance();

        return self;
    }
}

class SearchInputCallback extends DelayCallback {
    protected let m_addon: wref<ListControlAddon>;

    public func Call() {
        if IsDefined(this.m_addon) {
            this.m_addon.TriggerSearchEvent();
        }
    }

    public static func Create(addon: ref<ListControlAddon>) -> ref<SearchInputCallback> {
        let self = new SearchInputCallback();
        self.m_addon = addon;
        return self;
    }
}
