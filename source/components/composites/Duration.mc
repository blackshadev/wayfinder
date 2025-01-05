import Toybox.Graphics;
import Toybox.Lang;

class Duration extends RelativeComponent {
    private const FORMAT = "$1$:$2$";

    private var label as $.Text;
    private var value as $.Text;

    function initialize(offset as Graphics.Point2D) {
        RelativeComponent.initialize();

        self.label = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_XTINY, 
            :color => Graphics.COLOR_LT_GRAY, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT,
            :text => Rez.Strings.labelDuration
        });

        self.value = new $.Text({
            :offset => [offset[0], offset[1]], 
            :font => Graphics.FONT_LARGE, 
            :color => Graphics.COLOR_WHITE, 
            :justification => Graphics.TEXT_JUSTIFY_RIGHT
        });
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

    function setValue(value as Number?) as Void {
        if (value == null) {
            self.value.setText("--:--");
            return;
        }

        var hours = value / 3600000;
        var minutes = value / 60000 % 60;
        var seconds = value / 1000 % 60;

        if (hours == 0) {
            self.value.setText(
                Lang.format(FORMAT, [minutes, seconds.format("%02d")])
            );
        } else {
            self.value.setText(
                Lang.format(FORMAT, [hours, minutes.format("%02d")])
            );
        }
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