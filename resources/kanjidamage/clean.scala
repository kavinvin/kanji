import scala.io.Source
import java.io._

def open(fileName: String, f: PrintWriter => Unit) = {
  val printWriter = new PrintWriter(new File(fileName))
  printWriter.close()
}


val lines = Source.fromFile("curated-kanji.txt").getLines.toList
val pattern = "http://www.kanjidamage.com/kanji/\\d+-(.*)-(.)$".r
val kanjis = lines map {_ match {
  case pattern(a, b) => Some(b, a)
  case _ => None
}}

//open("quizlet.tsv", (_.write(kanjis.flatten.map(t => s"${t._1}\t${t._2}").mkString("\n"))))
val result = kanjis.flatten.map(t => s"${t._1}\t${t._2}").mkString("\n")
val printWriter = new PrintWriter(new File("quizlet.tsv"))
printWriter.write(result)
printWriter.close()
