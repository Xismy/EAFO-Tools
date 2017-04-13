package gui;

import java.awt.BorderLayout;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;

import data.AdaptacionMicrostrip;
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
	private JLabel lbzs1, lbys1, lbzs2, lbys2,
	lbzs1_2, lbys1_2, lbzs2_2, lbys2_2;
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
		
		tf_zs = new JTextField("50+j20");
		jtfdim.setSize(tf_zs.getMaximumSize().getWidth(), tf_zs.getPreferredSize().getHeight());
		tf_zs.setMaximumSize(jtfdim);
		interfaz.add(tf_zs);
		tf_zs.setColumns(10);
		
		JLabel lbl_zl = new JLabel("<html> Z<sub>L</sub> </html>");
		interfaz.add(lbl_zl);
		
		tf_zl = new JTextField("20+j50");
		tf_zl.setMaximumSize(jtfdim);
		interfaz.add(tf_zl);
		tf_zl.setColumns(10);
		
		JButton btnNewButton = new JButton("Calcular");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				float[] zs = leerComplejo(tf_zs.getText());
				float[] zl = leerComplejo(tf_zl.getText());
				float[] sol;
				AdaptacionMicrostrip adaptacionMicrostrip = new AdaptacionMicrostrip(zs[0], zs[1], zl[0], zl[1], 50);
				
				if(zs==null || zl==null)
					return;
				adaptacionMicrostrip.calculaLongitudes();
				//adaptacionMicrostrip.resolverStub();
				redAdaptacion.setParam(zs[0], zs[1], zl[0], zl[1]);
				redAdaptacion.resolverL1();
				sol = redAdaptacion.getSol(0);
				lbzs1.setText("S1: "+sol[0]);
				lbys1.setText("S1: "+sol[1]);
				sol = redAdaptacion.getSol(1);
				lbzs2.setText("S2: "+sol[0]);
				lbys2.setText("S2: "+sol[1]);
				
				redAdaptacion.resolverL2();
				sol = redAdaptacion.getSol(2);
				lbzs1_2.setText("S1: "+sol[0]);
				lbys1_2.setText("S1: "+sol[1]);
				sol = redAdaptacion.getSol(3);
				lbzs2_2.setText("S2: "+sol[0]);
				lbys2_2.setText("S2: "+sol[1]);
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
		
		JLabel lbL1 = new JLabel("");
		ImageIcon image = new ImageIcon(EAFO_Tools.class.getResource("/gui/L1.PNG"));
		image = new ImageIcon(image.getImage().getScaledInstance(600, 300, Image.SCALE_DEFAULT));
		
		lbzs1 = new JLabel("S1");
		lbzs1.setBounds(313, 93, 100, 14);
		layeredPane.add(lbzs1);
		
		lbzs2 = new JLabel("S2");
		lbzs2.setBounds(313, 109, 100, 14);
		layeredPane.add(lbzs2);
		
		lbys1 = new JLabel("S1");
		lbys1.setBounds(344, 210, 100, 14);
		layeredPane.add(lbys1);
		
		lbys2 = new JLabel("S2");
		lbys2.setBounds(344, 235, 100, 14);
		layeredPane.add(lbys2);
		lbL1.setIcon(image);
		lbL1.setBounds(30, 30, 600, 300);
		layeredPane.add(lbL1);
		
		JLayeredPane layeredPane_1 = new JLayeredPane();
		layeredPane_1.setPreferredSize(new Dimension(600, 330));
		panel_1.add(layeredPane_1);
		
		lbzs1_2 = new JLabel("S1");
		lbzs1_2.setBounds(431, 96, 100, 14);
		layeredPane_1.add(lbzs1_2);
		
		lbzs2_2 = new JLabel("S2");
		lbzs2_2.setBounds(431, 114, 100, 14);
		layeredPane_1.add(lbzs2_2);
		
		lbys1_2 = new JLabel("S1");
		lbys1_2.setBounds(350, 158, 100, 14);
		layeredPane_1.add(lbys1_2);
		
		lbys2_2 = new JLabel("S2");
		lbys2_2.setBounds(350, 176, 100, 14);
		layeredPane_1.add(lbys2_2);
		
		JLabel lbL2 = new JLabel("");
		lbL2.setBounds(30, 30, 600, 300);
		layeredPane_1.add(lbL2);
		image = new ImageIcon(EAFO_Tools.class.getResource("/gui/L2.PNG"));
		image = new ImageIcon(image.getImage().getScaledInstance(600, 300, Image.SCALE_DEFAULT));
		lbL2.setIcon(image);
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
