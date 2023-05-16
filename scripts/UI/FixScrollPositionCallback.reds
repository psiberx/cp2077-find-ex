module FindEx

public class FixScrollPositionCallback extends DelayCallback {
    protected let m_scrollController: wref<inkScrollController>;
    protected let m_scrollLastPosition: Float;
    protected let m_scrollLastDelta: Float;

    public func Call() {
        if IsDefined(this.m_scrollController) {
            this.m_scrollController.SetScrollPosition(
                this.m_scrollLastPosition * this.m_scrollLastDelta / this.m_scrollController.scrollDelta
            );
        }
    }

    public static func Create(controller: ref<inkScrollController>) -> ref<FixScrollPositionCallback> {
        let self = new FixScrollPositionCallback();
        self.m_scrollController = controller;
        self.m_scrollLastPosition = controller.position;
        self.m_scrollLastDelta = controller.scrollDelta;
        return self;
    }
}
