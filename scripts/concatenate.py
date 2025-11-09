import os
import glob
import argparse

def concatenate_typ_files(folder, output_file="concatenated.txt"):
    """
    Concatenates all .typ files found recursively in a specified folder
    into a single text file.

    Args:
        folder (str): The path to the folder to scan.
        output_file (str): The name of the output text file.  Defaults to "concatenated.txt".
    """

    typ_files = glob.glob(os.path.join(folder, "**/*.typ"), recursive=True)

    if not typ_files:
        print("No .typ files found.")
        return

    try:
        with open(output_file, "w", encoding="utf-8") as outfile:
            for filepath in typ_files:
                try:
                    with open(filepath, "r", encoding="utf-8") as infile:
                        content = infile.read()
                        outfile.write(content + "\n\n")
                except UnicodeDecodeError:
                    print(f"Skipping file {filepath} due to decoding error.")
                except Exception as e:
                    print(f"Error reading or writing file {filepath}: {e}")

        print(f"Successfully concatenated .typ files into {output_file}")

    except Exception as e:
        print(f"An error occurred during concatenation: {e}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Concatenate .typ files from a folder.")
    parser.add_argument("folder", help="The folder to scan for .typ files.")
    args = parser.parse_args()

    concatenate_typ_files(args.folder)
