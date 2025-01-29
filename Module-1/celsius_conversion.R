# Converts a temperature value from Kelvin to Celsius

KelvinToCelsius <- function(kelvin) 
{
  celsius = kelvin - 273
  return(celsius)
}

# Example usage

temperature_celsius <- KelvinToCelsius(274)
print(temperature_celsius) # Prints the result: 1°C
