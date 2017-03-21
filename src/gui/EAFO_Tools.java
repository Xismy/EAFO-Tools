package gui;

import java.awt.BorderLayout;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import data.RedAdaptacion;

import javax.swing.JTabbedPane;
import java.awt.FlowLayout;
import javax.swing.JTextField;
import javax.swing.JLabel;
import java.awt.GridLayout;
import java.awt.Image;

import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JSeparator;
import javax.swing.SwingConstants;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Panel;
import javax.swing.JScrollPane;
import javax.swing.JLayeredPane;
import javax.swing.JOptionPane;
import javax.swing.ScrollPaneConstants;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import data.RedAdaptacion;

public class EAFO_Tools extends JFrame {

	private JPanel contentPane;
	private JTextField tf_zs;
	private JTextField tf_zl;
	private JLabel lbz1s1;
	private JLabel lbz2s1;
	private RedAdaptacion redAdaptacion = new RedAdaptacion();

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					EAFO_Tools frame = new EAFO_Tools();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public EAFO_Tools() {
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 800, 600);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		contentPane.add(tabbedPane, BorderLayout.CENTER);
		
		JPanel panel = new JPanel();
		tabbedPane.addTab("New tab", null, panel, null);
		
		JPanel red_adaptacion = new JPanel();
		tabbedPane.addTab("Red Adaptaci\u00F3n", null, red_adaptacion, null);
		red_adaptacion.setLayout(new BorderLayout(0, 0));
		
		JPanel interfaz = new JPanel();
		red_adaptacion.add(interfaz, BorderLayout.EAST);
		interfaz.setLayout(new BoxLayout(interfaz, BoxLayout.Y_AXIS));
		
		Dimension jtfdim = new Dimension();
		
		JLabel lbl_zs = new JLabel("<html> Z<sub>S</sub> </html>");
		interfaz.add(lbl_zs);
		
		tf_zs = new JTextField();
		jtfdim.setSize(tf_zs.getMaximumSize().getWidth(), tf_zs.getPreferredSize().getHeight());
		tf_zs.setMaximumSize(jtfdim);
		interfaz.add(tf_zs);
		tf_zs.setColumns(10);
		
		JLabel lbl_zl = new JLabel("<html> Z<sub>L</sub> </html>");
		interfaz.add(lbl_zl);
		
		tf_zl = new JTextField();
		tf_zl.setMaximumSize(jtfdim);
		interfaz.add(tf_zl);
		tf_zl.setColumns(10);
		
		JButton btnNewButton = new JButton("Calcular");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				float[] zs = leerComplejo(tf_zs.getText());
				float[] zl = leerComplejo(tf_zl.getText());
				float[] sol;
				
				if(zs==null || zl==null)
					return;
				
				redAdaptacion.setParam(zs[0], zs[1], zl[0], zl[1]);
				redAdaptacion.resolverL();
				sol = redAdaptacion.getSol(0);
				lbz1s1.setText(""+sol[0]);
				lbz2s1.setText(""+sol[1]);
			}
		});
		interfaz.add(btnNewButton);
		
		JScrollPane scrollPane = new JScrollPane();
		red_adaptacion.add(scrollPane, BorderLayout.CENTER);
		
		JPanel panel_1 = new JPanel();
		scrollPane.setViewportView(panel_1);
		panel_1.setLayout(new BoxLayout(panel_1, BoxLayout.Y_AXIS));
		
		JLayeredPane layeredPane = new JLayeredPane();
		layeredPane.setPreferredSize(new Dimension(600, 330));
		panel_1.add(layeredPane);
		
		JLabel label = new JLabel("");
		ImageIcon image = new ImageIcon(EAFO_Tools.class.getResource("/gui/L1.PNG"));
		image = new ImageIcon(image.getImage().getScaledInstance(600, 300, Image.SCALE_DEFAULT));
		
		lbz1s1 = new JLabel("S1");
		lbz1s1.setBounds(313, 93, 46, 14);
		layeredPane.add(lbz1s1);
		
		lbz2s1 = new JLabel("S1");
		lbz2s1.setBounds(398, 210, 46, 14);
		layeredPane.add(lbz2s1);
		label.setIcon(image);
		label.setBounds(30, 30, 600, 300);
		layeredPane.add(label);
		
		JLayeredPane layeredPane_1 = new JLayeredPane();
		layeredPane_1.setPreferredSize(new Dimension(600, 330));
		panel_1.add(layeredPane_1);
		
		JLabel label2 = new JLabel("");
		label2.setBounds(30, 30, 600, 300);
		layeredPane_1.add(label2);
		image = new ImageIcon(EAFO_Tools.class.getResource("/gui/L2.PNG"));
		image = new ImageIcon(image.getImage().getScaledInstance(600, 300, Image.SCALE_DEFAULT));
		label2.setIcon(image);
	}
	
	static float[] leerComplejo(String dato){
		String[] complejo;
		float[] resultado ={0,0};
		
		dato = dato.replaceAll("\\s", "");
		complejo = dato.split("j");
		
		try{
			if(complejo.length==2){
				complejo[1] = complejo[0].charAt(complejo[0].length()-1)+complejo[1];
				resultado[1] = Float.parseFloat(complejo[1]);
				complejo[0] = complejo[0].substring(0, complejo[0].length()-1);
			}
			resultado[0] = Float.parseFloat(complejo[0]);
		}
		catch(NumberFormatException ex){
			JOptionPane.showMessageDialog(null, "Formato incorrecto.");
			return null;
		}
		return resultado;
	}
}
