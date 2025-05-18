import Toybox.Lang;

class AverageValueList {
    private var _averages as Array<MovingAverage> = [];
    private var _limitIndices as Array<Number> = [];

    function initialize(sizes as Array<Number>) {
        for (var iX = 0; iX < sizes.size(); iX++) {
            self._averages.add(new MovingAverage(sizes[iX]));
            self._limitIndices.add(sizes[iX] - 1);
        }
    }

    public function add(value as Float, oldValues as Array<Float>) as Void {
        for (var iX = 0; iX < self._averages.size(); iX++) {
            self._averages[iX].add(value, oldValues[iX]);
        }
    }

    public function values() as Array<Float> {
        var values = [] as Array<Float>;
        for (var iX = 0; iX < self._averages.size(); iX++) {
            values.add(self._averages[iX].value());
        }

        return values;
    }

    public function reset() as Void {
        for (var iX = 0; iX < self._averages.size(); iX++) {
            self._averages[iX].reset();
        }
    }

    public function limitIndices() as Array<Number> {
        return self._limitIndices;
    }
}