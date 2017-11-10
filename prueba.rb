# Crear un menú con 4 opciones:
# Se debe validar, en caso que se ingrese otra opción, que la opción
# escogida sea 1, 2, 3, o 4. Por ende, si se ingresa cualquier otra opción el
# programa debe mostrar que la opción es inválida, mostrar nuevamente
# el menú y la posibilidad de volver a ingresar una opción
# Opción 1: Debe generar un archivo con el nombre de cada alumno y el
# promedio de sus notas.
# Se puede leer el archivo completo o ir leyendo y procesando
# por línea, ambas opciones son válidas.
# Opción 2: Debe contar la cantidad de inasistencias totales y mostrarlas en
# pantalla.
# Opción 3: Debe mostrar los nombres de los alumnos aprobados. Para eso
# se debe crear un método que reciba -como argumento- la nota necesaria pa
# aprobar, por defecto esa nota debe ser 5.
# Opción 4: Debe terminar el programa.

#---------------------------------------------------------------------------------

def sep(titulo)
  puts "\n\n" + "-" * 40 + '  ' + titulo.to_s + '  ' + "-" * 40
end

def pausa()
  puts "\n << Presione Enter para continuar >>"
  x = gets
end

def clear()
  system('clear')
end

def createFileAverage()
  sep "PROMEDIOS"
  data = []
  fileW = File.open('promedios.csv', 'w')
  File.open('alumnos.csv', 'r') { |file| data = file.readlines}
  data.each do |ele|
    arreglo = ele.split(', ')
    promedio = arreglo.map(&:to_f).inject(&:+) / (arreglo.size.to_f - 1)
    fileW.puts arreglo[0] + ', ' + promedio.to_s
    puts arreglo[0] + " promedio: #{promedio} "
  end
  fileW.close
end

def mostrarInasistencias()
  sep "INASISTENCIAS"
  data = []
  File.open('alumnos.csv', 'r') { |file| data = file.readlines}
  data.each do |ele|
    arreglo = ele.gsub("\n", "").split(', ')
    i = 0
    arreglo.each do |value|
        i =+1 if value == 'A'
    end
    puts "Inasistencias de #{arreglo[0]} : #{i}"
  end
end

def mostrarAprobados(nota = 5)
  createFileAverage()
  sep "APROBADOS"
  data = []
  File.open('promedios.csv', 'r') { |file| data = file.readlines}
  data.each do |ele|
    arreglo = ele.split(', ')
    puts "Alumno  #{arreglo[0]} aprobado con nota #{arreglo[1].to_s}" if arreglo[1].to_f >= nota
  end
end

#---------------------------------------------------------------------------------
sep "MENU"
op = 0

while op != 4
  clear
  sep 'MENU'
  p '1. Generar promedios en promedios.csv'
  p '2. Mostrar Inasistencias'
  p '3. Mostrar aprobados'
  p '4. Salir'

  puts "\n\nIngrese opcion:"
  op = gets.chomp.to_i

    if op == 1
      clear()
      createFileAverage()
    end
    #---------------------------------------------------------------------------------
    if op == 2
      clear()
      mostrarInasistencias()
    end
    #---------------------------------------------------------------------------------
    if op == 3
      clear()
      mostrarAprobados()
    end
    #---------------------------------------------------------------------------------
    if op > 4 or op < 0
      puts "Opcion invalida, debe ingresar opciones del 1 al 4"
    end

    if op!=4
      pausa()
    end
end
clear
