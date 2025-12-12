import Toybox.Graphics;
import Toybox.Lang;

class WindDirectionArrow extends RelativeComponent {
    private var _windDirection as WindDirectionControllerInterface;

    private var _line as RadialLine;
    private var _head as FilledArrow;
    private var _isAbsolute as Boolean;

    function initialize(
        settings as SettingsControllerInterface,
        windDirection as WindDirectionControllerInterface,
        isAbsolute as Boolean
    ) {
        RelativeComponent.initialize();

        self._windDirection = windDirection;
        self._isAbsolute = isAbsolute == true;

        self._head = new FilledArrow({
            :size => settings.arrowSizeValue(),
            :color => Graphics.COLOR_LT_GRAY
        });

        self._line = new RadialLine({
            :size => 2,
            :color => Graphics.COLOR_LT_GRAY
        });
    }

    public function update() as Void {
        var direction = self._windDirection.getWindDirection();

        if (direction != null) {
            // TODO: something with _isAbsolute
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