import java.text.MessageFormat;

// Class for calculate all run time (and count) of specific function in specific class.
public class HelpRunTime {
    public Double Time;
    public Integer RunCount;
    public String ClassName;


    public HelpRunTime(Double _Time, Integer _RunCount, String _ClassName) {
        Time = _Time;
        RunCount = _RunCount;
        ClassName = _ClassName;
    }


    public String toString(String FunctionName) {
        return MessageFormat.format(
                "Function {0} in {1} ran {2} times and took in total {3} ms",
                ClassName, FunctionName, RunCount, Time);
    }

    // return instance of the class.
    public static HelpRunTime GetInstance(Double Time, String ClassName) {
        return new HelpRunTime(Time, 1, ClassName);
    }

    // new calculate of run time.
    public HelpRunTime newRunTime(Double _Time) {
        RunCount++;
        Time += _Time;
        return this;
    }
}
