public class DurationTimeBasic {
    public double startTime;
    public double endTime;

    public double getDuration() {
        return startTime - endTime;
    }

    public void ResetTime() { startTime = endTime = 0; }
}
