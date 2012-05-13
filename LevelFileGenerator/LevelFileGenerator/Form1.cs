using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace LevelFileGenerator
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (folderBrowserDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string folder = "C:\\Users\\APPEK\\Minikin\\src\\Minikin\\Assets\\Ogmo";
            string[] filePaths = Directory.GetFiles(folder);

            StreamWriter w = new StreamWriter(folder + "/LevelManager.as");
            w.WriteLine("package Minikin.Assets.Ogmo");
            w.WriteLine("{");
            w.WriteLine("public class LevelManager");
            w.WriteLine("{");


            for (int i = 0; i < filePaths.Length; i++)
            {
                String fileName = Path.GetFileName(filePaths[i]);
                w.WriteLine("[Embed(source=\"" + fileName + "\", mimeType = \"application/octet-stream\")] public static const LVL_" + fileName.Substring(0, fileName.Length - 4).ToUpper() + ":Class;");
            }

            w.WriteLine("public static function getLevel(name:String):Class {");
            for (int i = 0; i < filePaths.Length; i++)
            {
                String fileName = Path.GetFileName(filePaths[i]);
                fileName = fileName.Substring(0, fileName.Length - 4);
                w.WriteLine("if (name == \"" + fileName + "\") return LVL_" + fileName.ToUpper() + ";");
            }
            w.WriteLine("return null;");
            w.WriteLine("}");

            w.WriteLine("}");
            w.WriteLine("}");
            w.Close();

            this.Close();
        }
    }
}
