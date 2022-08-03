# Bloco de teste

################### TESTE 1 ###################
echo "Executing test: example_01"

# 1. Cria exemplos em tabela Schedule
psql -U postgres -d transaction -a -f src/input/example_01.sql

# 2. Cria tabela de arestas e detecta ciclos

# 4. Compara com resultado sh analyse_files.sh original.out result.out
sh analyse_files.sh result.out output/example_01.out

# 5. Deleta exemplo de tabela Schedule (delete) 
psql -U postgres -d transaction -a -f src/clean_schedule.sql
