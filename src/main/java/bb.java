import org.aspectj.lang.JoinPoint;
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
class MainApp {
    public static void main(String[] args) {
        Weld weld = new Weld();
        WeldContainer container = weld.initialize();
        Student student = container.select(Student.class).get();
        student.setAge(22);
        student.setName("Assaf");
        student.getAge();
        student.getName();
    }
}



