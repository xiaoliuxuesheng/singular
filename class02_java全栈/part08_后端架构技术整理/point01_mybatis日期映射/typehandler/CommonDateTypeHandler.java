package com.panda.seckill.config.typehandler;

import com.panda.seckill.common.CommonMethods;
import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 * mybatis日期类型处理器:Date
 * 将Date类型的属性转为毫秒值的时间戳
 *
 * @author lxd
 * @version 1.0.0
 */
public class CommonDateTypeHandler extends BaseTypeHandler<Date> {

    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
        ps.setLong(i, CommonMethods.timeToTimestamp(parameter));
    }

    @Override
    public Date getNullableResult(ResultSet rs, String columnName) throws SQLException {
        return CommonMethods.timestamp2Date(rs.getLong(columnName));
    }

    @Override
    public Date getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        return CommonMethods.timestamp2Date(rs.getLong(columnIndex));
    }

    @Override
    public Date getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        return CommonMethods.timestamp2Date(cs.getLong(columnIndex));
    }
}
