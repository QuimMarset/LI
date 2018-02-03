#haciendo make, a partir de un archivo nombre.pl se genera un ejecutable llamado nombre

file = exercicis

$(file): $(file).pl
	swipl -O -q -g main --stand_alone=true -o $(file) -c $(file).pl


