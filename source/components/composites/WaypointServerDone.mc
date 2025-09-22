import Toybox.Graphics;
import Toybox.Lang;

class WaypointRetrievalDone extends RelativeComponent {
    private var label as $.Text;
    private var count as $.Text;
    private var backLabel as $.Text;
    private var busyIndicator as $.BusyIndicator;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();
        
        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :text => Rez.Strings.waypointsRetrieved,
        });

        self.count = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_MEDIUM, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :text => ""
        });

        self.backLabel = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_TINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :fitTextToArea => true,
            :text => Rez.Strings.waypointsResume,
        });

        self.busyIndicator = new BusyIndicator([offset[0], offset[1]]);
    }

    function setOffset(offset as Point2D) as Void {
        RelativeComponent.setOffset(offset);

        self.label.setOffset(offset);
        self.count.setOffset(offset);
        self.backLabel.setOffset(offset);
        self.busyIndicator.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([self.label, self.count, self.backLabel, self.busyIndicator]);
    }

    function setCount(count as Number) as Void {
        self.count.setText(Lang.format("$1$ waypoints", [count]));
    }

    function layout(dc as Dc) as Void {
        self.label.layout(dc);
        self.count.layout(dc);
        self.backLabel.layout(dc);
        self.busyIndicator.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.label.draw(dc);
        self.count.draw(dc);
        self.backLabel.draw(dc);
        self.busyIndicator.draw(dc);
    }

    public function height() as Number { 
        return self.label.height() + self.count.height() + self.backLabel.height() + self.busyIndicator.height(); 
    }
}