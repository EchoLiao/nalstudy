/*
 * @(#)BasicFormattedTextFieldUI.java	1.5 05/11/17
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package javax.swing.plaf.basic;

import javax.swing.*;
import javax.swing.plaf.ComponentUI;

/**
 * Provides the look and feel implementation for
 * <code>JFormattedTextField</code>.
 *
 * @version 1.5 11/17/05
 * @since 1.4
 */
public class BasicFormattedTextFieldUI extends BasicTextFieldUI {
    /**
     * Creates a UI for a JFormattedTextField.
     *
     * @param c the formatted text field
     * @return the UI
     */
    public static ComponentUI createUI(JComponent c) {
        return new BasicFormattedTextFieldUI();
    }

    /**
     * Fetches the name used as a key to lookup properties through the
     * UIManager.  This is used as a prefix to all the standard
     * text properties.
     *
     * @return the name "FormattedTextField"
     */
    protected String getPropertyPrefix() {
	return "FormattedTextField";
    }
}
