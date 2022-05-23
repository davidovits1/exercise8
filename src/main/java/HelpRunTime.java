public class HelpRunTime {
    public Double Time;
    public Integer RunCount;

    public HelpRunTime(Double _Time, Integer _RunCount) {
        Time = _Time;
        RunCount = _RunCount;
    }

    public static HelpRunTime GetInstance(Double Time) {
        return new HelpRunTime(Time, 1);
    }

    public HelpRunTime newRunTime(Double _Time) {
        RunCount++;
        Time += _Time;
        return this;
    }
}
