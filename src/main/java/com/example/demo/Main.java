package com.example.demo;

import net.sf.jsqlparser.JSQLParserException;
import net.sf.jsqlparser.parser.CCJSqlParserUtil;
import net.sf.jsqlparser.schema.Table;
import net.sf.jsqlparser.statement.Statements;
import net.sf.jsqlparser.statement.create.table.ColumnDefinition;
import net.sf.jsqlparser.statement.create.table.CreateTable;
import net.sf.jsqlparser.statement.drop.Drop;
import net.sf.jsqlparser.statement.insert.Insert;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) throws IOException, JSQLParserException {
        // 你的MySQL DDL路径
        String mysqlDDLPath = "mysql.sql";
        String origindDLs = getFileContent(new File(mysqlDDLPath));
        String dDLs=origindDLs.replaceAll(" USING BTREE", "")
        .replaceAll(" CHARACTER SET utf8 COLLATE utf8_general_ci", "")
        .replaceAll(" CHARACTER SET = utf8 COLLATE = utf8_general_ci", "")
                .replaceAll("ENGINE=InnoDB ", "")
                .replaceAll("ENGINE = InnoDB ", "")
                .replaceAll("engine=innodb ", "")
                .replaceAll("AUTO_INCREMENT=\\d+ ", "")
                .replaceAll("AUTO_INCREMENT = \\d+ ", "")
                .replaceAll("auto_increment=\\d+ ", "")
                .replaceAll("DEFAULT CHARSET=utf8 ", "")
                .replaceAll("CURRENT_TIMESTAMP\\(\\)", "LOCALTIMESTAMP")
                .replaceAll("DEFAULT CHARSET=utf8mb4  COLLATE=utf8mb4_bin", "")
                .replaceAll("DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", "")
                .replaceAll("COLLATE utf8mb4_bin", "")
                .replaceAll("ROW_FORMAT=DYNAMIC", "")
                .replaceAll("ROW_FORMAT = Dynamic", "");



        System.out.println(dDLs);
        System.out.println("++++++++++开始转换SQL语句+++++++++++++");

        Statements statements = CCJSqlParserUtil.parseStatements(dDLs);

        statements.getStatements()
                .stream()
                .filter(statement -> {
                    if(statement instanceof Drop){
                        System.out.println(statement.toString().replaceAll("`", "")+";");
                        return false;
                    }
                    if(statement instanceof Insert){
                        System.out.println(statement.toString().replaceAll("`", "")+";");
                        return false;
                    }
                    return true;
                })
                .map(statement ->(CreateTable) statement).forEach(ct -> {
            Table table = ct.getTable();
            List<ColumnDefinition> columnDefinitions = ct.getColumnDefinitions();
            List<String> comments = new ArrayList<>();
            List<ColumnDefinition> collect = columnDefinitions.stream()
                    .peek(columnDefinition -> {
                        List<String> columnSpecStrings = columnDefinition.getColumnSpecStrings();

                        int commentIndex = getCommentIndex(columnSpecStrings);

                        if (commentIndex != -1) {
                            int commentStringIndex = commentIndex + 1;
                            String commentString = columnSpecStrings.get(commentStringIndex);

                            String commentSql = genCommentSql(table.toString(), columnDefinition.getColumnName(), commentString);
                            comments.add(commentSql);
                            columnSpecStrings.remove(commentStringIndex);
                            columnSpecStrings.remove(commentIndex);
                        }
                        columnDefinition.setColumnSpecStrings(columnSpecStrings);
                    }).collect(Collectors.toList());
            ct.setColumnDefinitions(collect);
            String createSQL = ct.toString()
                    .replaceAll("`", "")


                    .replaceAll("BIGINT UNIQUE NOT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("BIGINT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("bigint NOT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("BIGINT NOT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("INT NOT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("INT NULL AUTO_INCREMENT", "BIGSERIAL PRIMARY KEY")
                    .replaceAll("IF NOT EXISTS", "")
                    .replaceAll("tinyint\\(\\d+\\)", "TINYINT")
                    .replaceAll("tinyint \\(\\d+\\)", "TINYINT")
                    .replaceAll("longblob", "varchar(4000)")
                    .replaceAll("DATETIME", "TIMESTAMP")
                    .replaceAll("datetime", "TIMESTAMP")
                    .replaceAll("bigint \\(\\d+\\)", "INTEGER")
                    .replaceAll("bigint\\(\\d+\\)", "INTEGER")
                    .replaceAll("int \\(\\d+\\)", "INTEGER")
                    .replaceAll("int\\(\\d+\\)", "INTEGER")
                    .replaceAll("INTEGER not null auto_increment", "SERIAL PRIMARY KEY")
                    .replaceAll("INTEGER NOT NULL AUTO_INCREMENT", "SERIAL PRIMARY KEY")
                    .replaceAll("INTEGER NOT NULL auto_increment", "SERIAL PRIMARY KEY")
                    .replaceAll(", PRIMARY KEY \\(\"\\w+\"\\)", "")
                    .replaceAll(", primary key \\(\"\\w+\"\\)", "")
                    .replaceAll(", PRIMARY KEY \\([a-zA-Z ,_]+\\)", "")
                    .replaceAll(", primary key \\([a-zA-Z ,_]+\\)", "")
                    .replaceAll(", unique key \\(\"\\w+\"\\)", "")
                    .replaceAll(", unique key \\(\\w+\\)", "");


            String tableComment="";
            // 如果存在表注释
            if (createSQL.contains("comment")) {
                tableComment=createSQL.substring(createSQL.indexOf("comment = ")+10);
                createSQL = createSQL.substring(0, createSQL.indexOf("comment"));
            }
            if (createSQL.contains("COMMENT")) {
                tableComment=createSQL.substring(createSQL.indexOf("COMMENT = ")+10);
                createSQL = createSQL.substring(0, createSQL.indexOf("COMMENT"));
            }
            System.out.println(createSQL + ";");
            if(tableComment.length()>0){
                System.out.println("COMMENT ON TABLE "+table.getName().replaceAll("`", "").replaceAll("\"", "")+" IS "+tableComment+";");
            }

            comments.forEach(t -> System.out.println(t.replaceAll("`", "\"") + ";"));
        });
    }

    private static String getFileContent(File file) {
        try {
            byte[] bytes = Files.readAllBytes(Paths.get(file.getPath()));
            return new String(bytes, Charset.forName("UTF-8"));

        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";

    }

    /**
     * 获得注释的下标
     *
     * @param columnSpecStrings columnSpecStrings
     * @return 下标
     */
    private static int getCommentIndex(List<String> columnSpecStrings) {
        for (int i = 0; i < columnSpecStrings.size(); i++) {
            if ("COMMENT".equalsIgnoreCase(columnSpecStrings.get(i))) {
                return i;
            }
        }
        return -1;
    }

    /**
     * 生成COMMENT语句
     *
     * @param table        表名
     * @param column       字段名
     * @param commentValue 描述文字
     * @return COMMENT语句
     */
    private static String genCommentSql(String table, String column, String commentValue) {
        return String.format("COMMENT ON COLUMN %s.%s IS %s", table, column, commentValue);
    }
}