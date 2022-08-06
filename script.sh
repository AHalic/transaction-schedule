# Bloco de teste

psql -U postgres -d transaction -a -f src/create_schedule.sql

################### TESTE 1 ###################
echo "Executing test: example_01"

# 1. Cria exemplos em tabela Schedule
psql -U postgres -d transaction -a -f src/input/example_01.sql

# 2. Cria tabela de arestas e detecta ciclos
psql -U postgres -d transaction -a -f src/create_graph.sql

# 4. Compara com resultado sh analyse_files.sh original.out result.out
# sh analyse_files.sh result.out output/example_01.out

# 5. Deleta exemplo de tabela Schedule (delete) 
psql -U postgres -d transaction -a -f src/clean_schedule.sql


################### TESTE 2 ###################
# echo "Executing test: example_02"

# # 1. Cria exemplos em tabela Schedule
# psql -U postgres -d transaction -a -f src/input/example_02.sql

# # 2. Cria tabela de arestas e detecta ciclos
# psql -U postgres -d transaction -a -f src/create_graph.sql

# # 4. Compara com resultado sh analyse_files.sh original.out result.out
# # sh analyse_files.sh result.out output/example_01.out

# # 5. Deleta exemplo de tabela Schedule (delete) 
# psql -U postgres -d transaction -a -f src/clean_schedule.sql
