import Toybox.Graphics;
import Toybox.Lang;

class WaypointRetrievalStatus extends RelativeComponent {
    private var label as $.Text;
    private var code as $.Text;
    private var target as $.Text;
    private var busyIndicator as BusyIndicator;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();
        
        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :text => "Device Code"
        });

        self.code = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_MEDIUM, 
            :color => Utils.Colors.foreground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :text => "----"
        });

        self.target = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_TINY, 
            :color => Utils.Colors.greyForeground, 
            :justification => Graphics.TEXT_JUSTIFY_CENTER,
            :fitTextToArea => true,
            :text => "on wayfinder.littledev.nl"
        });

        self.busyIndicator = new BusyIndicator([offset[0], offset[1]]);
    }

    function setCode(code as String) as Void {
        self.code.setText(code);
    }

    function setOffset(offset as Point2D) as Void {
        RelativeComponent.setOffset(offset);

        self.code.setOffset(offset);
        self.target.setOffset(offset);
        self.label.setOffset(offset);
        self.busyIndicator.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Downwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([label, self.code, self.target, self.busyIndicator]);
    }

    function layout(dc as Dc) as Void {
        self.label.layout(dc);
        self.code.layout(dc);
        self.target.layout(dc);
        self.busyIndicator.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.label.draw(dc);
        self.code.draw(dc);
        self.target.draw(dc);
        self.busyIndicator.draw(dc);
    }

    public function height() as Number { 
        return self.label.height() + self.code.height() + self.target.height() + self.busyIndicator.height(); 
    }
}