package com.panda.mybatisspringboot.commons.config;

import com.panda.mybatisspringboot.commons.standard.IEnum;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MyBatisEnumHandler<E extends IEnum> extends BaseTypeHandler<IEnum> {
    private final E[] enums;

    public MyBatisEnumHandler(Class<E> type) {
        if (type == null) {
            throw new IllegalArgumentException("Type argument cannot be null");
        }
        this.enums = type.getEnumConstants();
        if (this.enums == null) {
            throw new IllegalArgumentException(type.getSimpleName() + " does not represent an enum type.");
        }
    }

    /**
     * 在Mybatis设置参数时把{IEnum}类型的值设置到对应的数据表字段
     *
     * @param ps        当前的PreparedStatement对象
     * @param i         当前参数的位置
     * @param parameter 当前参数的Java对象
     * @param jdbcType  当前参数的数据库类型
     * @throws SQLException 数据设置异常
     */
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, IEnum parameter, JdbcType jdbcType) throws SQLException {
        if (jdbcType == null) {
            ps.setObject(i, parameter.getValue());
        } else {
            ps.setObject(i, parameter.getValue(), jdbcType.TYPE_CODE);
        }
    }

    /**
     * 把Mybatis获取数据结果集的数据库列名的数据转换为对应的Java类型
     *
     * @param rs         当前的结果集
     * @param columnName 当前的字段名称
     * @return 转换后的Java对象
     * @throws SQLException 数据设置异常
     */
    @Override
    public E getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Object code = rs.getObject(columnName);

        if (rs.wasNull()) {
            return null;
        }

        return getEnmByCode(code);
    }

    /**
     * 把Mybatis获取数据结果集时的数据库列索引位置的数据转换为对应的Java类型
     *
     * @param rs          当前的结果集
     * @param columnIndex 当前的字段索引位置
     * @return 转换后的Java对象
     * @throws SQLException 数据设置异常
     */
    @Override
    public E getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Object code = rs.getObject(columnIndex);
        if (rs.wasNull()) {
            return null;
        }

        return getEnmByCode(code);
    }

    /**
     * 用于Mybatis在调用存储过程后把数据库类型的数据转换为对应的Java类型
     *
     * @param cs          当前的CallableStatement执行后的CallableStatement
     * @param columnIndex 当前输出参数的位置
     * @return 转换后的Java对象
     * @throws SQLException 数据设置异常
     */
    @Override
    public E getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Object code = cs.getObject(columnIndex);
        if (cs.wasNull()) {
            return null;
        }
        return getEnmByCode(code);
    }


    /**
     * 根据{IEnum.getValue}的值,获取到对应的枚举对象
     *
     * @param code 枚举的Value的值
     * @return 枚举对象
     */
    private E getEnmByCode(Object code) {

        if (code == null) {
            throw new NullPointerException("the result code is null ");
        }

        if (code instanceof String) {
            for (E e : enums) {
                if (code.equals(e.getValue())) {
                    return e;
                }
            }
            throw new IllegalArgumentException("Unknown enumeration type , please check the enumeration code :  " + code);
        }

        throw new IllegalArgumentException("Unknown enumeration type , please check the enumeration code :  " + code);
    }
}
