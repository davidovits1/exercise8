
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;

@Aspect
public class AlgorithmRunnerTime {

    private DurationTimeBasic durationTime;
    private HashMap<String, HelpRunTime> RunnerTimes;

    public AlgorithmRunnerTime() {
        durationTime = new DurationTimeBasic();
        RunnerTimes = new HashMap<>();
    }

    private void Add(String functionName, Double DurationTime) {
        if (RunnerTimes.containsKey(functionName))
            RunnerTimes.put(functionName, RunnerTimes.get(functionName).newRunTime(DurationTime));

        else
            RunnerTimes.put(functionName, HelpRunTime.GetInstance(DurationTime));
    }

    @Pointcut("execution(* *.*.sort*(..))")
    private void selectAllSort() {
    }

    @Before("selectAllSort()")
    public void beforeRunningTime() {
        durationTime.startTime = System.currentTimeMillis();
    }

    @After("selectAllSort()")
    public void afterRunningTime(JoinPoint joinPoint) {
        durationTime.endTime = System.currentTimeMillis();
        Double _durationTime = durationTime.getDuration();
        String functionName = joinPoint.getSignature().getName() + " " + joinPoint.getThis();
        Add(functionName, _durationTime);
        durationTime.ResetTime();
    }

    @Pointcut("execution(* *.*.runAlgorithms*(..))")
    private void selectAllSortsTime() {
    }

    @After("selectAllSortsTime()")
    public void AfterAllSorts() {
        double sumOfRunning = 0;

        for (Map.Entry<String, HelpRunTime> helpRunTimeEntry : RunnerTimes.entrySet()) {
            var functionAndThis = helpRunTimeEntry.getKey().split(" ");
            var helpRunTime = helpRunTimeEntry.getValue();
            System.out.println(MessageFormat.format(
                    "Function {0} in {1} ran {2} times and took in total {3} ms",
                    functionAndThis[0], functionAndThis[1], helpRunTime.RunCount,
                    helpRunTime.Time));

            sumOfRunning += helpRunTime.Time;
        }

        System.out.println("Total time of running all sort functions was " + sumOfRunning + " ms \n");
    }
}




/*import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.jboss.weld.environment.se.Weld;
import org.jboss.weld.environment.se.WeldContainer;

import javax.inject.Inject;

interface Pet {
}




class Dog implements Pet {
    @Override
    public String toString() {
        return "Dog";
    }
}





class Student {
    private Integer age;
    private String name;

    Pet itsPet;

    @Inject
    public Student(Pet pet) {
        itsPet = pet;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Integer getAge() {
        return age;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Loggable
    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "Student, name: " + name + ", age: " + age + ", pet: " + itsPet;
    }
}

@Aspect
class Logging {

    @Pointcut("execution(* *.*.set*(..))")
    private void selectSetters() {
    }

    @Pointcut("@annotation(Loggable) && execution(* *(..))")
    private void selectLoggable() {
    }

    @Before("selectSetters()")
    public void beforeSetters(JoinPoint jp) {
        System.out.println("Calling " + jp.getSignature().getName()
                + " with " + jp.getArgs()[0]);
    }

    @Before("selectLoggable()")
    public void beforeLoggable(JoinPoint jp) {
        System.out.println("Calling loggable function " + jp.getSignature().getName() + " from " + jp.getThis());
    }
}
class mainApp {
    public static void main(String[] args) {
        Weld weld = new Weld();
        WeldContainer container = weld.initialize();
        Student student = container.select(Student.class).get();
        student.setAge(22);
        student.setName("Assaf");
        student.getAge();
        student.getName();
    }
}*/

