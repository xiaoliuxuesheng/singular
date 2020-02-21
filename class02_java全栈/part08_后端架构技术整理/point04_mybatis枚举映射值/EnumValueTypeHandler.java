package com.singularity.retail.config.mybatis.typehandler;

import com.singularity.retail.standard.common.BaseEnum;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EnumValueTypeHandler<E extends BaseEnum> extends BaseTypeHandler<E> {

    private final Class<E> type;
    private final E[] enums;

    public EnumValueTypeHandler(Class<E> type) {
        if (type == null) {
            throw new IllegalArgumentException("Type argument cannot be null");
        }
        this.type = type;
        this.enums = this.type.getEnumConstants();
        if (this.enums == null) {
            throw new IllegalArgumentException(type.getSimpleName() + " does not represent an enum type.");
        }
    }

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, E parameter, JdbcType jdbcType) throws SQLException {
        //BaseTypeHandler 进行非空校验
        if (jdbcType == null) {
            ps.setObject(i, parameter.getValue());
        } else {
            ps.setObject(i, parameter.getValue(), jdbcType.TYPE_CODE);
        }
    }

    @Override
    public E getNullableResult(ResultSet rs, String columnName) throws SQLException {
        Object code = rs.getObject(columnName);

        if (rs.wasNull()) {
            return null;
        }

        return getEnmByCode(code);
    }

    @Override
    public E getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        Object code = rs.getObject(columnIndex);
        if (rs.wasNull()) {
            return null;
        }

        return getEnmByCode(code);
    }

    @Override
    public E getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        Object code = cs.getObject(columnIndex);
        if (cs.wasNull()) {
            return null;
        }
        return getEnmByCode(code);
    }

    private E getEnmByCode(Object code) {

        if (code == null) {
            throw new NullPointerException("the result code is null ");
        }

        if (code instanceof Integer) {
            for (E e : enums) {
                if (e.getValue() == code) {
                    return e;
                }
            }
            throw new IllegalArgumentException("Unknown enumeration type , please check the enumeration code :  " + code);
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
