import Toybox.Graphics;
import Toybox.Lang;

class WindDirectionArrow extends RelativeComponent {
    private var _windDirection as WindDirectionControllerInterface;

    private var _line as RadialLine;
    private var _head as HollowArrow;
    private var _isAbsolute as Boolean;

    function initialize(
        settings as SettingsControllerInterface,
        windDirection as WindDirectionControllerInterface,
        isAbsolute as Boolean
    ) {
        RelativeComponent.initialize();

        self._windDirection = windDirection;
        self._isAbsolute = isAbsolute == true;

        self._head = new HollowArrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_DK_GRAY,
            :stroke => 2,
        });

        self._line = new RadialLine({
            :stroke => 2,
            :offset => settings.arrowSizeValue() + settings.arrowSizeValue() / 2,
            :color => Graphics.COLOR_DK_GRAY
        });
    }

    public function update() as Void {
        var direction = self._isAbsolute ? self._windDirection.getWindDirection() : self._windDirection.getRelativeWindDirection();

        if (direction != null) {
            self._head.setAngle(direction);
            self._line.setAngle(direction);
        }
    }

    public function layout(dc as Dc) as Void {
        self._head.layout(dc);
        self._line.layout(dc);
    }

    public function draw(dc as Dc) as Void {
        if (self._windDirection.shouldShow()) {
            self._head.draw(dc);
            self._line.draw(dc);
        }
    }
}