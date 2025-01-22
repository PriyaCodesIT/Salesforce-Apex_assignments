public class fitness {
    public static Decimal calculateBMI(Decimal weight, Decimal height){
      Decimal BMI = weight/(height * height);
      return BMI;  
    }
    
    public static Decimal calculatePace(Decimal distance, Decimal timeInMinutes){
      Decimal timeInHours = timeInMinutes / 60;
      Decimal pace = distance / timeInHours;
      return pace;  
    }
}