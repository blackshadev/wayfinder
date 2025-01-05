import Toybox.Graphics;
import Toybox.Lang;

class AverageSpeed extends RelativeComponent {
    private var label as $.Text;
    private var value as $.Text;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Graphics.COLOR_LT_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelAverageSpeed
        });
        
        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_LARGE, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT 
        });

        self.setValue(null);
    }

    function setValue(value as SpeedValue?) as Void {
        if (value == null) {
            self.value.setText("--");
            return;
        }

        self.value.setText(value.average.format("%0.1f"));
    }

    function setOffset(offset) as Void {
        RelativeComponent.setOffset(offset);

        self.label.setOffset(offset);
        self.value.setOffset(offset);

        (new Layout.Vertical({ 
            :direction => Layout.Upwards, 
            :spacing => Utils.Sizing.spacing 
        })).apply([self.label, self.value]);
    }

    function layout(dc as Dc) as Void {
        self.label.layout(dc);
        self.value.layout(dc);
    }

    function draw(dc as Dc) as Void {
        self.label.draw(dc);
        self.value.draw(dc);
    }
}