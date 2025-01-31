import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.WatchUi;

class ViewController {
    private var views as Array<WatchUi.View> = [];
    private var iX as Number = 0;
    private var dir as Number = 0;
    private var activity as ActivityController;
    private var delegate as WayfinderDelegate? = null;

    function initialize(activity as ActivityController) {
        self.activity = activity;
    }

    function setViews(views as Array<WatchUi.View>) as Void {
        self.views = views;
    }

    function setDelegate(delegate as WayfinderDelegate) as Void {
        self.delegate = delegate;
    }

    function back() as Void {
        if (self.iX == 0) {
            self.confirmExitMenu();
            return;
        }

        self.reset();
    }

    function confirmExitMenu() as Void {
         var menuBuilder = new ExitMenuBuilder(self.activity);

        WatchUi.pushView(
            menuBuilder.build(),
            new ExitMenuDelegate(self.activity),
            WatchUi.SLIDE_LEFT
        );
    }

    function reset() as Void {
        if (self.iX == 0) {
            return;
        }

        self.iX = 0;

        WatchUi.switchToView(
            self.views[self.iX], 
            self.delegate, 
            self.backAnimation()
        );
    }

    function next() as Void {
        self.iX = (self.iX + 1) % self.views.size();
        self.dir = 1;

        WatchUi.switchToView(
            self.views[self.iX], 
            self.delegate, 
            WatchUi.SLIDE_UP
        );
    }

    function previous() as Void {
        self.iX = self.iX - 1;
        if (self.iX < 0) {
            self.iX = self.views.size() + self.iX;
        }

        self.dir = -1;

        WatchUi.switchToView(
            self.views[self.iX], 
            self.delegate, 
            WatchUi.SLIDE_DOWN
        );
    }

    public function resetView() as Void {
        WatchUi.switchToView(
            self.views[self.iX], 
            self.delegate, 
            WatchUi.SLIDE_IMMEDIATE
        );
        WatchUi.requestUpdate();
    }

    private function backAnimation() as WatchUi.SlideType {
        if (self.dir == -1) {
            return WatchUi.SLIDE_UP;
        }

        return WatchUi.SLIDE_DOWN;
    }

    function getView() as [ WatchUi.Views, WatchUi.InputDelegates ] {
        return [self.views[self.iX], self.delegate];
    }

}