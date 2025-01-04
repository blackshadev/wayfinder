import Toybox.ActivityRecording;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.WatchUi;

class ViewController {
    private var views as Array<WatchUi.View> = [];
    private var iX as Number = 0;
    private var dir as Number = 0;
    private var delegate as WayfinderDelegate? = null;

    function initialize(views as Array<WatchUi.View>) {
        self.views = views;
        self.delegate = delegate;
    }

    function setDelegate(delegate as WayfinderDelegate) as Void {
        self.delegate = delegate;
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

    private function backAnimation() as WatchUi.SlideType {
        if (self.dir == -1) {
            return WatchUi.SLIDE_UP;
        }

        return WatchUi.SLIDE_DOWN;
    }

    function getView() {
        return [self.views[self.iX], self.delegate];
    }

}