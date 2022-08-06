# Variables
TEST_DIR=src/test

# Create schedule table
psql -U postgres -d transaction -q -f src/algorithm/create_schedule.sql

# Run tests
for FILEPATH in $TEST_DIR/input/*.sql; do
    FILENAME=$(basename "$FILEPATH" .sql)

    echo "\n*****************************************************************************\n"

    echo "Executing test: $FILENAME"

    # 1. Cria exemplos em tabela Schedule
    psql -U postgres -d transaction -q -f src/test/input/$FILENAME.sql

    # 2. Cria tabela de arestas e detecta ciclos
    # Flags: q:quiet output, t:tuple output, A:no align, 0:changes separator to "", f:input file, o:output file
    psql -U postgres -d transaction -q -A -t -f src/algorithm/find_cycle.sql -o /src/output/$FILENAME.out

    # 4. Compara com resultado sh analyse_files.sh original.out result.out
    sh src/analyse_files.sh src/output/$FILENAME.out src/test/output/$FILENAME.out

    # 5. Deleta exemplo de tabela Schedule (delete) 
    psql -U postgres -d transaction -q -f src/algorithm/clean_schedule.sql
done