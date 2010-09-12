/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package javax.faces.model;

import java.util.List;

/**
 * see Javadoc of <a href="http://java.sun.com/javaee/javaserverfaces/1.2/docs/api/index.html">JSF Specification</a>
 * 
 * @author Thomas Spiegl (latest modification by $Author: slessard $)
 * @version $Revision: 761981 $ $Date: 2009-04-04 13:44:14 -0500 (Sat, 04 Apr 2009) $
 */
public class ListDataModel<E> extends DataModel<E>
{

    // FIELDS
    private int _rowIndex = -1;
    private List<E> _data;

    // CONSTRUCTORS
    public ListDataModel()
    {
        super();
    }

    public ListDataModel(List<E> list)
    {
        if (list == null)
            throw new NullPointerException("list");
        setWrappedData(list);
    }

    // METHODS
    @Override
    public int getRowCount()
    {
        if (_data == null)
        {
            return -1;
        }
        return _data.size();
    }

    @Override
    public E getRowData()
    {
        if (_data == null)
        {
            return null;
        }
        if (!isRowAvailable())
        {
            throw new IllegalArgumentException("row is unavailable");
        }
        return _data.get(_rowIndex);
    }

    @Override
    public int getRowIndex()
    {
        return _rowIndex;
    }

    @Override
    public Object getWrappedData()
    {
        return _data;
    }

    @Override
    public boolean isRowAvailable()
    {
        return _data != null && _rowIndex >= 0 && _rowIndex < _data.size();
    }

    @Override
    public void setRowIndex(int rowIndex)
    {
        if (rowIndex < -1)
        {
            throw new IllegalArgumentException("illegal rowIndex " + rowIndex);
        }
        int oldRowIndex = _rowIndex;
        _rowIndex = rowIndex;
        if (_data != null && oldRowIndex != _rowIndex)
        {
            E data = isRowAvailable() ? getRowData() : null;
            DataModelEvent event = new DataModelEvent(this, _rowIndex, data);
            DataModelListener[] listeners = getDataModelListeners();
            for (int i = 0; i < listeners.length; i++)
            {
                listeners[i].rowSelected(event);
            }
        }
    }

    @Override
    public void setWrappedData(Object data)
    {
        _data = (List<E>)data;
        int rowIndex = _data != null ? 0 : -1;
        setRowIndex(rowIndex);
    }

}
