module FindEx
import Codeware.UI.*

public class NestedListControlAddon extends ListControlAddon {
    protected cb func OnCreate() {
        super.OnCreate();

        let buttonPanel = new inkHorizontalPanel();
        buttonPanel.SetChildMargin(new inkMargin(8.0, 0.0, 0.0, 0.0));
        buttonPanel.Reparent(this.m_root);

        let expandBtn = CollapseButton.Create();
        expandBtn.SetFlipped(true);
        expandBtn.Reparent(buttonPanel);

        let collapseBtn = CollapseButton.Create();
        collapseBtn.SetCollapse(true);
        collapseBtn.Reparent(buttonPanel);
    }

    public static func Create() -> ref<NestedListControlAddon> {
        let self = new NestedListControlAddon();
        self.CreateInstance();

        return self;
    }
}
