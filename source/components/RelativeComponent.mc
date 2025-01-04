import Toybox.Graphics;
import Toybox.Lang;

class RelativeComponent extends Component {
    protected var _offset as Graphics.Point2D = [0, 0];

    function initialize() {
        Component.initialize();
    }

    public function offset() as Graphics.Point2D {
        return self._offset;
    }

    public function setOffset(offset as Graphics.Point2D) as Void {
        self._offset = offset;
    }

    public function updateOffset(x as Number?, y as Number?) as Void {
        if (x == null) {
            x = self._offset[0];
        }
        
        if (y == null) {
            y = self._offset[1];
        }

        self._offset = [x, y];
    }

    public function height() as Number { 
        throw new NotImplemented(); 
    }
}