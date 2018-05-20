#!/usr/bin/env ruby.ruby2.4
$:.unshift File.dirname($0)
#$#KCODE = 'UTF8'

#------------------------------------------------------------------------------
#
# slideviewer v0.1
#
#------------------------------------------------------------------------------
#
# author: Ig (development@aynoa.net)
# description: a simple image viewer using ruby and Qt4.
#
#------------------------------------------------------------------------------
#
#  Installation & configuration
#
#  ruby, rubygems, or equivalent packages,
# are required. wget is required to donwload files from internet.
#
#  1) Copy slideviewer.rb to ~/bin
#  2) Edit file permissions and check "Is executable".
#  3) Optional, but really useful, is create a desktop icon to the program :).
#  4) If you try slideviewer -h in console you can see:
#
#------------------------------------------------------------------------------
#
# Usage: slideviewer [options] [URL]
#
# Specific options:
#     -c, --cfg FILE                   Alternate configuration file (default '~/.config/slideviewerrc').
#     -w, --write_cfg [FILE]           Creates/overwrites a configuration file.
#     -f, --frameless                  Disable window frame.
#     -p, --print_cfg                  Prints program configuration.
#     -l, --layout [LAYOUT]            Loads LAYOUT layout.
#
# Common options:
#     -h, --help                       Show this message.
#     -v, --version                    Show version.
#
#------------------------------------------------------------------------------
#
# Hot-Keys
# --------
# c         -> copy viewed image to a new window.
# f         -> window frame toggle.
# esc       -> quit.
# insert    -> reload.
# del       -> delete image.
# F2        -> rename file.
# h         -> shortcuts help.
#
# o         -> restore zoom / best fit toggle.
# +         -> zoom +.
# -         -> zoom -.
#
# ctrl+-    -> rotate 90º left.
# ctrl++    -> rotate 90º right.
#
# space     -> next image (mouse wheel down).
# backspace -> previous image (mouse wheel up).
# home      -> first image.
# end       -> last image.
# ctrl+space-> jumps forward 10 images.
# ctrl+backspace-> jumps backward 10 images.
#
# s         -> save layout.
# ctrl+s    -> overwrite layout.
# l         -> load layout.
# e         -> erase layout
# ctrl+e    -> clear layout.
#
# ctrl+w    -> start/stop secuential slideshow.
# ctrl+r    -> start/stop random slideshow.
# p         -> pause/unpause slideshow.
#
# F11       -> toggle fullscreen mode.
#
# Ctrl+C    --> open image with Chrome.
# Ctrl+K    --> open image with Krita.
# Ctrl+D    --> open image with ShowPhoto.
# Ctrl+F    --> open image location in default file manager.
# Ctrl+O    --> open image.
#
#  Use left button & mouse to move image, alt + left button & mouse to move
# the form.
#
#------------------------------------------------------------------------------
#
# Default configuration
# ---------------------
#
# auto_resize = true                           -- Autofit the image.
# key_chrome = 67108931                        -- Qt::ControlModifier + Qt::Key_C - Ctrl+C.
# key_krita = 67108939                         -- Qt::ControlModifier + Qt::Key_K - Ctrl+K.
# key_showphoto = 67108932                     -- Qt::ControlModifier + Qt::Key_D - Ctrl+D.
# key_copy = 67                                -- Qt::Key_C - C.
# key_delete = 16777223                        -- Qt::Key_Delete - Del.
# key_insert = 16777222                        -- Qt::Key_Insert - Insert.
# key_rename = 16777265                        -- Qt::Key_F2 - F2.
# key_help = 72                                -- Qt::Key_H - H.
# key_filemanager = 67108934                   -- Qt::ControlModifier + Qt::Key_F - Ctrl+F.
# key_first = 16777232                         -- Qt::Key_Home - Home.
# key_frameless_toggle = 70                    -- Qt::Key_F - F.
# key_fullscreen_toggle = 16777274             -- Qt::Key_F11 - F11.
# key_last = 16777233                          -- Qt::Key_End -Qt::ControlModifier End.
# key_next = 32                                -- Qt::Key_Space - Space.
# key_next_jump = 67108896                     -- Qt::ControlModifier + Qt::Key_Space - Ctrl+Space.
# key_open = 67108943                          -- Qt::ControlModifier + Qt::Key_O - Ctrl+O.
# key_previous = 16777219                      -- Qt::Key_Backspace - Backspace.
# key_previous_jump = 83886083                 -- Qt::ControlModifier + Qt::Key_Backspace - Ctrl+Backspace.
# key_quit = 16777216                          -- Qt::Key_Escape - ESC.
# key_rotate_left = 67108909                   -- Qt::ControlModifier + Qt::Key_Minus - Ctrl+Minus.
# key_rotate_right = 67108907                  -- Qt::ControlModifier + Qt::Key_Plus - Ctrl+Plus.
# key_layout_clear = 67108933                  -- Qt::ControlModifier + Qt::Key_E - E.
# key_layout_delete = 69                       -- Qt::Key_E - E.
# key_layout_load = 76                         -- Qt::Key_L - L.
# key_layout_overwrite = 67108947              -- Qt::ControlModifier + Qt::Key_S - Ctrl+S.
# key_layout_save = 83                         -- Qt::Key_S - S.
# key_slideshow_pause = 80                     -- Qt::Key_P - P.
# key_slideshow_secuencial = 67108951          -- Qt::ControlModifier + Qt::Key_W - Ctrl+W.
# key_slideshow_random = 67108946              -- Qt::ControlModifier + Qt::Key_R - Ctrl+R.
# key_zoomin = 43                              -- Qt::Key_Plus - +.
# key_zoomout = 45                             -- Qt::Key_Minus - -.
# key_zoomrestore = 79                         -- Qt::Key_O - O.
# scroll_bars_policy = 1                       -- Don't change this.
# show_in_caption_dimensions = false           -- Show dimensions in form caption.
# show_in_caption_dir = false                  -- Show directory in caption.
# show_in_caption_index = true                 -- Show image number and total images in caption.
# show_in_caption_zoom = true                  -- Show zoom in caption.
# url = ""                                     -- Default image/directory to open.
# valid_extensions = "bmp,gif,jpg,jpeg,png,pbm,pgm,ppm,tiff,xpm,xbm"
# version = "0.10"                             -- Program version.
# window_desktop_height_adjust = 28            -- Desktop height adjust.
# window_desktop_width_adjust = 8              -- Desktop width adjust.
# zoom_factor = 0.1                            -- Zoom factor.
# zoom_factor_maximum = 4                      -- Maximum zoom factor.
# zoom_factor_mininum = 0.1                    -- Minimum zoom factor.
#
#------------------------------------------------------------------------------
#
# changelog
# ----- 17/05/2018 -----
# version 0.1 - first version release:
#
#------------------------------------------------------------------------------
#
# TODO 1.0
#
# - multilenguaje.
# - albumes y tags recursivos. Poder pasar de un modo a otro rápidamente.
# - utilizar QGraphicsScene en vez de una QLabel (y ver si aumenta la velocidad).
# - drag & drop para releer, para añadir imágenes o una carpeta.
# - mejorar la gestión de errores.
# - menú de contexto con opciones.
# - menú de contexto con abrir con... (que lo lea del propio KDE), abrir
#  carpeta, etc...
# - ¿soporte para ficheros comprimidos.?
# - comentar el código.
# - etc...
#
#------------------------------------------------------------------------------

# gem.ruby2.4 install qtbindings
# gem.ruby2.4 install exifr
# gem.ruby2.4 install mimemagic

#begin
#  require 'pry'
#rescue LoadError => e
#  DEBUG_ON = false
#else
#  DEBUG_ON = true
#end
#Qt.debug_level = Qt::DebugLevel::High
#Qt::Internal::setDebug(Qt::QtDebugChannel::QTDB_VIRTUAL)
#Qt::Internal::setDebug(Qt::QtDebugChannel::QTDB_GC)

#
# Error box function.
#
def error_box(message = 'No message')

  system('kdialog', '--error', message)

end # error_box


#
# Constantes.
#
PROGRAM_NAME = 'slideviewer'
PROGRAM_FILE_NAME = "#{PROGRAM_NAME}"
PROGRAM_VERSION = '0.1'
PROGRAM_TITLE = PROGRAM_NAME + ' v' + PROGRAM_VERSION
PROGRAM_AUTHOR = 'ig'
PROGRAM_EMAIL = 'development@aynoa.net'

ZOOM_AUTOFIT = -9999
ZOOM_NO = 1

GO_FIRST = 1
GO_NEXT = 2
GO_PREVIOUS = 3
GO_LAST = 4
GO_NEXT_JUMP = 5
GO_PREVIOUS_JUMP = 6
GO_CURRENT = 7

SLIDESHOW_STOP = 0
SLIDESHOW_RANDOM = 1
SLIDESHOW_SECUENTIAL = 2
SLIDESHOW_SAVED = 4
SLIDESHOW_PAUSED = 8

PROTOCOL_FILE = 0
PROTOCOL_HTTP = 1
PROTOCOL_HTTPS = 2
PROTOCOL_FTP = 3

DECORATOR_HACK_HEIGHT = 6
DECORATOR_HACK_WIDTH = 6

if (ENV['KDE_SESSION_VERSION'] == '5')
  cfg_path = ENV['HOME'] + '/.'
elsif (ENV['KDE_SESSION_VERSION'] == '4')
  cfg_path = `kde4-config --localprefix`.chomp + 'share/'
elsif (ENV['DESKTOP_SESSION'] == 'kde')
  cfg_path = `kde-config --localprefix`.chomp + 'share/'
else
  cfg_path = ENV['HOME'] + '/.'
end
PROGRAM_CFG = cfg_path + "config/#{PROGRAM_NAME}rc"

TMP_DIR = ENV['TMPDIR'] || '/tmp'


#
# Librerias.
#
begin
  require 'rubygems'
  require 'bundler/setup'
  require 'optparse'
  require 'ostruct'
  require 'pathname'
rescue LoadError => e
  message = PROGRAM_TITLE + ': Error! loading some basic library: rubygems, optparse, ostruct, pathname or bundler.'
  puts message
  error_box(message)
  exit()
end

begin
  require 'Qt4'
  require 'listen'
rescue LoadError => e
  message = PROGRAM_TITLE + ': Error! listen and qtbindings are required.'
  puts message
  error_box(message)
  exit()
end

begin
  require 'exifr'
  EXIFR_AVAILABLE = true
rescue LoadError => e
  EXIFR_AVAILABLE = false
end

begin
  require 'mimemagic'
  MIMEMAGIC_AVAILABLE = true
rescue LoadError => e
  MIMEMAGIC_AVAILABLE = false
end

#
# Mensajes.
#
MESSAGE_WARNING_NO_IMAGES = 'There aren not images to view.'
MESSAGE_WARNING_NO_IMAGES_IN_DIR = 'There is not supported files to view in "%s".'
MESSAGE_WARNING_DIRECTORY_DOES_NOT_EXISTS = 'Directory "%s" does not exists.'
MESSAGE_WARNING_NO_MORE_IMAGES_TO_DISPLAY = "There are no images to display."

MESSAGE_ERROR_IMAGE_CANT_LOCATE = 'Can not locate image "%s".'
MESSAGE_ERROR_IMAGE_DONT_EXISTS = 'Image "%s" does not exists.'
MESSAGE_ERROR_FORMAT_NOT_SUPPORTED = 'File "%s" format is not supported.'
MESSAGE_ERROR_FILE_LOAD_FAILS = 'File "%s" loading fails.'

MESSAGE_ERROR_LAYOUT_NOT_FOUND = 'Layout "%s" not found.'

MESSAGE_ERROR_LAYOUT_INVALID_NAME = '"%s" is not a valid name.'

MESSAGE_COMMAND_BANNER = "Program: %s, by %s (%s)\n\nUsage: %s [options] [URL]"
MESSAGE_COMMAND_SPECIFIC = 'Specific options:'
MESSAGE_COMMAND_C = 'Alternate configuration file (default "%s").'
MESSAGE_COMMAND_W = 'Creates/overwrites a configuration file.'
MESSAGE_COMMAND_F = 'Disable window frame.'
MESSAGE_COMMAND_P = 'Prints program configuration.'
MESSAGE_COMMAND_L = 'Loads LAYOUT layout.'
MESSAGE_COMMAND_COMMON = 'Common options:'
MESSAGE_COMMAND_H = 'Show this message.'
MESSAGE_COMMAND_V = 'Show version.'

MESSAGE_KDIALOG_OPEN = 'Select file or directory'
MESSAGE_KDIALOG_LAYOUT_TITLE = 'Layout name'
MESSAGE_KDIALOG_LAYOUT_NAME = 'new layout'
MESSAGE_KDIALOG_LAYOUT_SELECT = 'Select a layout'

MESSAGE_CLEAR_SELECTION_OPTION = '<clear selection>'

MESSAGE_KDIALOG_RENAME_FILE = 'New file name'

MESSAGE_HELP = "Help"
MESSAGE_HELP_SHORTCUTS = 
    "Shortcuts:\n" +
    "     c                copy viewed image to a new window.\n" +
    "     f                window frame toggle.\n" +
    "     esc              quit.\n" +
    "     insert           reload.\n" +
    "     del              delete image.\n" +
    "     F2               rename file.\n" +
    "     h                display shortcuts help.\n" +
    "     \n" +
    "     o                restore zoom / best fit toggle.\n" +
    "     +                increase zoom.\n" +
    "     -                decrease zoom.\n" +
    "\n" +
    "     ctrl+-           rotate 90º left.\n" +
    "     ctrl++           rotate 90º right.\n" +
    "\n" +
    "     space            next image (mouse wheel down).\n" +
    "     backspace        previous image (mouse wheel up).\n" +
    "     home             first image.\n" +
    "     end              last image.\n" +
    "     ctrl+space       jumps forward 10 images.\n" +
    "     ctrl+backspace   jumps backward 10 images.\n" +
    "\n" +
    "     s                save layout.\n" +
    "     ctrl+s           overwrite layout.\n" +
    "     l                load layout.\n" +
    "     e                erase layout.\n" +
    "     ctrl+e           clear layout.\n" +
    "\n" +
    "     ctrl+w           start/stop secuential slideshow.\n" +
    "     ctrl+r           start/stop random slideshow.\n" +
    "     p                pause/unpause slideshow.\n" +
    "\n" +
    "     F11              toggle fullscreen mode.\n" +
    "\n" +
    "     Ctrl+C           open image with chrome.\n" +
    "     Ctrl+K           open image with Krita.\n" +
    "     Ctrl+D           open image with ShowPhoto.\n" +
    "     Ctrl+F           open image location in default file manager.\n" +
    "     Ctrl+O           open image.\n" +
    "\n" +
    "     Use left button & mouse to move image, alt + left button & mouse to move the form."

MESSAGE_HELP_SHORTCUTS_HTML =
    "<b>Shortcuts</b>:\n" +
    "<table>\n"+
    "<tr><td> c              </td><td> copy viewed image to a new window </td></tr>\n" +
    "<tr><td> f              </td><td> window frame toggle </td></tr>\n" +
    "<tr><td> esc            </td><td> quit </td></tr>\n" +
    "<tr><td> insert         </td><td> reload </td></tr>\n" +
    "<tr><td> del            </td><td> delete image </td></tr>\n" +
    "<tr><td> F2             </td><td> rename file </td></tr>\n" +
    "<tr><td> h              </td><td> display shortcuts help </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> o              </td><td> restore zoom / best fit toggle </td></tr>\n" +
    "<tr><td> +              </td><td> increase zoom </td></tr>\n" +
    "<tr><td> -              </td><td> decrease zoom </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> ctrl+-         </td><td> rotate 90º left </td></tr>\n" +
    "<tr><td> ctrl++         </td><td> rotate 90º right </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> space          </td><td> next image (mouse wheel down) </td></tr>\n" +
    "<tr><td> backspace      </td><td> previous image (mouse wheel up) </td></tr>\n" +
    "<tr><td> home           </td><td> first image </td></tr>\n" +
    "<tr><td> end            </td><td> last image </td></tr>\n" +
    "<tr><td> ctrl+space     </td><td> jumps forward 10 images </td></tr>\n" +
    "<tr><td> ctrl+backspace </td><td> jumps backward 10 images </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> s              </td><td> save layout </td></tr>\n" +
    "<tr><td> ctrl+s         </td><td> overwrite layout </td></tr>\n" +
    "<tr><td> l              </td><td> load layout </td></tr>\n" +
    "<tr><td> e              </td><td> erase layout </td></tr>\n" +
    "<tr><td> ctrl+e         </td><td> clear layout </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> ctrl+w         </td><td> start/stop secuential slideshow </td></tr>\n" +
    "<tr><td> ctrl+r         </td><td> start/stop random slideshow </td></tr>\n" +
    "<tr><td> p              </td><td> pause/unpause slideshow </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> F11            </td><td> toggle fullscreen mode </td></tr>\n" +
    "<tr></td>\n" +
    "<tr><td> Ctrl+C         </td><td> open image with chrome </td></tr>\n" +
    "<tr><td> Ctrl+K         </td><td> open image with Krita </td></tr>\n" +
    "<tr><td> Ctrl+D         </td><td> open image with ShowPhoto </td></tr>\n" +
    "<tr><td> Ctrl+F         </td><td> open image location in default file manager </td></tr>\n" +
    "<tr><td> Ctrl+O         </td><td> open image </td></tr>\n" +
    "</table>\n"+
    "\n" +
    "Use left button & mouse to move image, alt + left button & mouse to move the form."



#
# Una QScrollArea con comportamientos concretos.
#
class RIVScrollArea < Qt::ScrollArea

  attr_accessor :restored_x
  attr_accessor :restored_y

  def initialize(parent = nil)

    super()

    setAlignment(Qt::AlignCenter)
    setSizePolicy(Qt::SizePolicy.Ignored, Qt::SizePolicy.Ignored)
    setBackgroundRole(Qt::Palette::WindowText)
    setLineWidth(0)
    setMidLineWidth(0)
    setFrameStyle(Qt::Frame::NoFrame + Qt::Frame.Plain)

    setHorizontalScrollBarPolicy($options.scroll_bars_policy)
    setVerticalScrollBarPolicy($options.scroll_bars_policy)

    @restored_x = nil
    @restored_y = nil

  end # initialize(parent = nil)

  def wheelEvent(event)

    event.ignore()

  end # wheelEvent(awheelevent)

  def mousePressEvent(event)

    # Esta ventana pasa a estar encima de las demás.
    WM.window_to_top(parent)

    if (event.button() == Qt::LeftButton)
      # Para evitar el problema de las ventanas restauradas forzamos la posición.
      if !restored_x.nil?
        horizontalScrollBar.setValue(@restored_x)
        @restored_x = nil
      end
      if !restored_y.nil?
        verticalScrollBar.setValue(@restored_y)
        @restored_y = nil
      end
      # Grabamos la posición y ponemos la mano.
      @lastDragPos = event.globalPos() # No usar pos() ya que ocasiona problemas.
      setCursor(Qt::Cursor.new(Qt::PointingHandCursor))
    end # (event.button() == Qt::LeftButton)

  end # mousePressEvent(event)

  def mouseMoveEvent(event)

    if (event.buttons() == Qt::LeftButton)

      position = event.globalPos() # No usar pos() ya que ocasiona problemas.
      if (event.modifiers == Qt::AltModifier)
        parent.move(parent.x + (position.x - @lastDragPos.x),
                      parent.y + (position.y - @lastDragPos.y))
      else # parent.frameless
        move_to(horizontalScrollBar.value() - (position.x - @lastDragPos.x),
                  verticalScrollBar.value() - (position.y - @lastDragPos.y))
      end # parent.frameless

      @lastDragPos = position

    end #(event.buttons() == Qt::LeftButton)

  end # mouseMoveEvent(event)

  def mouseReleaseEvent(event)

    if (event.button() == Qt::LeftButton)
      # Restauramos el cursor por defecto.
      unsetCursor()
    end # (event.button() == Qt::LeftButton)

  end # mouseReleaseEvent(event)

  def move_to(new_x = 0, new_y = 0, force = false)
    if (force or (new_x !=  horizontalScrollBar.value()))
      horizontalScrollBar.setValue(new_x)
    end
    if (force or (new_y !=  verticalScrollBar.value()))
      verticalScrollBar.setValue(new_y)
    end
  end

end # RIVScrollArea < Qt::ScrollArea


#
# Clase de la ventana de visualización y los principales comandos.
#
class RIVViewWindow < Qt::MainWindow

  attr_accessor :angle
  attr_accessor :frameless
  attr_accessor :fullscreen
  attr_accessor :image_file
  attr_accessor :use_previous_query
  attr_accessor :window_border_size_height
  attr_accessor :window_border_size_width
  attr_accessor :zoom_level

  # initialize()
  def initialize()

    super()

    # Configuración.
    @angle = 0
    @auto_resize = $options.auto_resize
    @frameless = ((windowFlags & Qt::FramelessWindowHint.to_i) > 0)
    @fullscreen = ((windowFlags & Qt::WindowFullScreen.to_i) > 0)
    @image_file = ''
    @show_in_caption_dir = $options.show_in_caption_dir
    @show_in_caption_index = $options.show_in_caption_index
    @show_in_caption_size = $options.show_in_caption_dimensions
    @show_in_caption_zoom = $options.show_in_caption_zoom
    @slideshow_mode = SLIDESHOW_STOP
    @slideshow_seconds = $options.slideshow_seconds
    @use_previous_query = false
    #OJO: es importante no modificar este patrón. Si se hace revisar el código
    @valid_extensions = ' .' +
        $options.valid_extensions.strip.gsub(',', ' .').downcase + ' '
    @valid_protocols = Array.new()
    @valid_protocols << ['http://', PROTOCOL_HTTP]
    @valid_protocols << ['https://', PROTOCOL_HTTPS]
    @valid_protocols << ['ftp://', PROTOCOL_FTP]
    @valid_protocols << ['file://', PROTOCOL_FILE]
    @window_border_size_height = 0
    @window_border_size_width = 0
    @zoom_level = 1.0

    # Inicialización.
    @curr_dir ||= './'
    @curr_image_index ||= 0
    #setBackgroundRole(Qt::Palette.Base)

    # Instantaneasmos un timer para el slideshow.
    @timer = Qt::BasicTimer.new()

    # Instantaneamos y configuramos el widget de visualización.
    @viewer = Qt::Label.new(self)
    @viewer.setSizePolicy(Qt::SizePolicy.Ignored, Qt::SizePolicy.Ignored)
    @viewer.setScaledContents(true)
    @viewer.setFocus()
    @viewer.setMargin(1)
    @viewer.setLineWidth(0)
    @viewer.setMidLineWidth(0)
    @viewer.setFrameStyle(Qt::Frame::NoFrame + Qt::Frame.Plain)

    #@viewer.setBackgroundRole(Qt::Palette.Base)

    # Añadimos un objeto RIVScrollArea para gestionar el scroll.
    @scrollarea = RIVScrollArea.new(self)
    @scrollarea.setWidget(@viewer)
    setCentralWidget(@scrollarea)

    @window_border_size_height = self.height() - @scrollarea.viewport.height()
    @window_border_size_width = self.width() - @scrollarea.viewport.width()

  end #  initialize(parent = nil)

  # keyPressEvent()
  def keyPressEvent(event)

    # Ignoramos el modificador del teclado expandido
    if (event.modifiers == 536870912)
      key = event.key
    elsif  (event.modifiers == 603979776)
      key = event.key + Qt::ControlModifier
    else
      key = event.key + event.modifiers
    end

    # En modo slideshow permitir únicamente unas teclas.
    if (key == $options.key_slideshow_secuential)
      slideshow((@slideshow_mode == SLIDESHOW_STOP) ? SLIDESHOW_SECUENTIAL : SLIDESHOW_STOP)
    elsif (key == $options.key_slideshow_random)
      slideshow((@slideshow_mode == SLIDESHOW_STOP) ? SLIDESHOW_RANDOM : SLIDESHOW_STOP)
    elsif (key == $options.key_slideshow_pause)
      if (@slideshow_mode != SLIDESHOW_STOP)
        @slideshow_mode += ((@slideshow_mode & SLIDESHOW_PAUSED) > 0) ?
                              -SLIDESHOW_PAUSED :
                              +SLIDESHOW_PAUSED
        set_caption()
      end # (@slideshow_mode != SLIDESHOW_STOP)
    elsif (key == $options.key_frameless_toggle)
      frameless_toggle()
    elsif (key == $options.key_fullscreen_toggle)
      fullscreen_toggle()
    elsif (key == $options.key_chrome)
        if not @image_file.to_s.empty?
            pid = Process.fork
            if pid.nil? then
                exec "google-chrome '%s'" % [@image_file.to_s]
            else
                Process.detach(pid)
            end
            #command = "google-chrome '%s'" % [@image_file.to_s]
            #result = ''
            #IO.popen(command, "r") do |pipe|
            #    result = pipe.read
            #end
            #result.chomp!
        end
    elsif (key == $options.key_copy)
      view_copy()
    elsif (key == $options.key_delete)
      delete_image()
    elsif (key == $options.key_insert)
      load_image(@image_file)
    elsif (key == $options.key_rename)
      rename_image(@image_file)
    elsif (key == $options.key_help)
      help()
    elsif (key == $options.key_filemanager)
      if not @image_file.to_s.empty?
          pid = Process.fork
          if pid.nil? then
            exec "kde-open5 '%s'" % [File.dirname(@image_file.to_s)]
          else
            Process.detach(pid)
          end
      end
    elsif (key == $options.key_quit)
      APP.exit()
    else
      # Nada.
    end

    if (@slideshow_mode != SLIDESHOW_STOP)
      return true
    end

    if (key == $options.key_next)
      show_next(false)
    elsif (key == $options.key_previous)
      show_previous(false)
    elsif (key == $options.key_next_jump)
      show_next(true)
    elsif (key == $options.key_previous_jump)
      show_previous(true)
    elsif (key == $options.key_krita)
        if not @image_file.to_s.empty?
            pid = Process.fork
            if pid.nil? then
                exec "krita '%s'" % [@image_file.to_s]
            else
                Process.detach(pid)
            end
            #command = "krita '%s'" % [@image_file.to_s]
            #result = ''
            #IO.popen(command, "r") do |pipe|
            #    result = pipe.read
            #end
            #result.chomp!
        end

    elsif (key == $options.key_showphoto)
        if not @image_file.to_s.empty?
            pid = Process.fork
            if pid.nil? then
                exec "showfoto '%s'" % [@image_file.to_s]
            else
                Process.detach(pid)
            end
            #command = "showfoto '%s'" % [@image_file.to_s]
            #result = ''
            #IO.popen(command, "r") do |pipe|
            #    result = pipe.read
            #end
            #result.chomp!
        end

    elsif (key == $options.key_first)
      show_first()
    elsif (key == $options.key_last)
      show_last()
    elsif (key == $options.key_zoomin)
      zoom_in()
    elsif (key == $options.key_zoomout)
      zoom_out()
    elsif (key == $options.key_zoomrestore)
      zoom((@zoom_level == 1) ?  ZOOM_AUTOFIT : ZOOM_NO)
    elsif (key == $options.key_open)
      $options._p_random_mode = false
      open_file()
    elsif (key == $options.key_rotate_left)
      rotate_left()
    elsif (key == $options.key_rotate_right)
      rotate_right()
    elsif (key == $options.key_layout_load)
      WM.layout_load()
    elsif (key == $options.key_layout_save)
      WM.layout_save()
    elsif (key == $options.key_layout_overwrite)
      WM.layout_overwrite()
    elsif (key == $options.key_layout_delete)
      WM.layout_delete()
    elsif (key == $options.key_layout_clear)
      WM.layout_clear()
    else
      # Nada.
    end

  end # keyPressEvent(event)

  # wheelEvent()
  def wheelEvent(event)

    if (@slideshow_mode != SLIDESHOW_STOP)
      return true
    end

    if (event.delta() > 0)
      show_previous()
    else # (event.delta() > 0)
      show_next()
    end # (event.delta() > 0)

  end # wheelEvent(awheelevent)

  # set_caption()
  def set_caption(filename = '', width = 0, height = 0)

    if (filename == '')
      filename = @image_file
    end

    if (width == 0)
      image_width = @image_width
    end

    if (height == 0)
      image_height = @image_height
    end

    filename = @show_in_caption_dir ?
                  '%s' % [filename] :
                  '%s' % [File.basename(filename)]

    slideshow_mode = ((@slideshow_mode & SLIDESHOW_RANDOM) > 0) ?
                        'r' :
                        ((@slideshow_mode & SLIDESHOW_SECUENTIAL) > 0) ? 's' : ''
    slideshow_feedback = (@slideshow_mode == SLIDESHOW_STOP) ?
                            '' :
                            ((@slideshow_mode & SLIDESHOW_PAUSED) > 0) ?
                              'S%s(P)' % [slideshow_mode] :
                              'S%s' % [slideshow_mode]

    #caption = '%s %s "%s"' % [PROGRAM_TITLE, slideshow_feedback, filename]
    caption = '%s %s' % [filename, slideshow_feedback]

    if (@show_in_caption_size and @show_in_caption_zoom)
      caption += ' (%sx%s %0.02fx)' % [image_width, image_height, @zoom_level]
    elsif @show_in_caption_size
      caption += ' (%sx%s)' % [image_width, image_height]
    elsif @show_in_caption_zoom
      caption += ' (%0.02fx)' % [@zoom_level]
    else
      # Nada.
    end # @show_in_caption_size

    if @show_in_caption_index
      caption += ' (%s/%s)' % [@curr_image_index.to_i + 1, @images.length]
    end # @show_in_caption_index

    setWindowTitle(caption)

  end # set_caption(filename = '', width = 0, height = 0)

  # set_size()
  #
  # Cambia el tamaño de la form.
  def set_size(new_width = 0, new_height = 0, desktop_geometry = 0)

    setCursor(Qt::Cursor.new(Qt::WaitCursor))

    #puts '%s x %s' % [window_width, window_height]
    window_width = new_width
    window_height = new_height
    viewer_width = new_width - @window_border_size_width
    viewer_height = new_height - @window_border_size_height

    if not ((@viewer.width == viewer_width) and (@viewer.height == viewer_height))
      @viewer.resize(viewer_width, viewer_height)
    end
    if not @fullscreen
      if not ((width == window_width) and (height == window_height))
        resize(window_width-DECORATOR_HACK_WIDTH, window_height-DECORATOR_HACK_HEIGHT)
      end
    end # |@fullscreen

    unsetCursor()

  end # set_size(width = 0, height = 0)

  # Zoom.
  def zoom(new_zoom_level = ZOOM_NO, force_refresh = false)

    if (new_zoom_level == ZOOM_AUTOFIT)
      # Si el valor es ZOOM_AUTOFIT hacemos un autofit.
      #puts "desktop: #{desktop_geometry.width}w x #{desktop_geometry.height}h"
      #puts "desktop: #{desktop_geometry.left}l - #{desktop_geometry.right}r"
      #puts "desktop: #{desktop_geometry.top}t - #{desktop_geometry.bottom}b"

      if @fullscreen

        desktop_geometry = APP.desktop().screenGeometry()
        new_zoom_level = [desktop_geometry.height.to_f / @image_height.to_f,
                          desktop_geometry.width.to_f / @image_width.to_f,
                          1 ].min

      else # @fullscreen

        desktop_geometry = APP.desktop().availableGeometry()
        if @frameless
          new_zoom_level = [desktop_geometry.height.to_f / @image_height.to_f,
                            desktop_geometry.width.to_f / @image_width.to_f,
                            1 ].min
        else # @frameless
          new_zoom_level = [(desktop_geometry.height.to_f - $options.window_desktop_height_adjust) / @image_height.to_f,
                            (desktop_geometry.width.to_f - $options.window_desktop_width_adjust) / @image_width.to_f,
                            1 ].min
        end #@frameless

      end # @fullscreen

    end # (new_zoom_level = ZOOM_AUTOFIT)

    new_zoom_level = ([new_zoom_level, $options.zoom_minimum, 0.01].max).to_f
    new_zoom_level = ([new_zoom_level, $options.zoom_maximum].min).to_f

    if (force_refresh or (new_zoom_level != @zoom_level))
      set_size((new_zoom_level * @image_width).to_i,
                (new_zoom_level * @image_height).to_i,
                desktop_geometry)
      @zoom_level = new_zoom_level.to_f
      set_caption()
    end # (force_refresh or (new_zoom_level != @zoom_level))

  end # zoom(new_zoom_level = ZOOM_NO)

  # zoom_in()
  #
  # Incrementa el zoom en la escala indicada en la configuración.
  def zoom_in()
    zoom(@zoom_level.to_f + $options.zoom_factor.to_f)
  end

  # zoom_out()
  #
  # Decrementa el zoom en la escala indicada en la configuración.
  def zoom_out()
    zoom(@zoom_level.to_f - $options.zoom_factor.to_f)
  end

  # rotate()
  #
  # Rota la imagen los grados indicados en new_angle.
  def rotate(new_angle = 0)

    transform_matrix = Qt::Transform.new()
    transform_matrix.rotate(new_angle)
    pixmap = @viewer.pixmap.transformed(transform_matrix)
    @viewer.setPixmap(pixmap.copy())
    @image_width = pixmap.width
    @image_height = pixmap.height

    # Forzamos el refresco en la llamada a Zoom() porque cambiamos la imagen.
    if @auto_resize
      zoom(ZOOM_AUTOFIT, true)
    else # @auto_resize
      zoom(ZOOM_NO, true)
    end # @auto_resize
    @angle = new_angle

  end # rotate(new_angle = 0)

  # rotate_left()
  #
  # Rota 90º la imagen a la izquierda.
  def rotate_left()
    rotate(-90)
  end

  # rotate_right()
  #
  # Rota 90º la imagen a la derecha.
  def rotate_right()
    rotate(90)
  end

  # show_move()
  #
  # Selecciona una imagen para visualizar según el párametro movement.
  def show_move(movement)

    setCursor(Qt::Cursor.new(Qt::WaitCursor))

    if (movement == GO_NEXT)
      # Go next.
      new_image_index = @curr_image_index + 1
      if (new_image_index >= @images.length)
        new_image_index = 0
      end
    elsif (movement == GO_PREVIOUS)
      # Go previous.
      new_image_index = @curr_image_index - 1
      if (new_image_index < 0)
        new_image_index = @images.length - 1
      end
    elsif (movement == GO_NEXT_JUMP)
      # Go next.
      new_image_index = @curr_image_index + $options.move_jump_size
      if (new_image_index >= @images.length)
        new_image_index -= @images.length
      end
    elsif (movement == GO_PREVIOUS_JUMP)
      # Go previous.
      new_image_index = @curr_image_index - $options.move_jump_size
      if (new_image_index < 0)
        new_image_index = @images.length + new_image_index
      end
    elsif (movement == GO_LAST)
      # Go last.
      new_image_index = @images.length - 1
    elsif (movement == GO_FIRST)
      # Go first.
      new_image_index = 0
    elsif (movement == GO_CURRENT)
      # Go current.
      new_image_index = @curr_image_index
      if (new_image_index >= @images.length)
        new_image_index = 0
      end
    #else
      #return false
    end

    # Solucionamos el salto de imágenes al haber un error.
    if not show_image(new_image_index)
      #@curr_image_index = -1
    end

    unsetCursor()

    return true

  end # show_move(movement)

  # Muestra la primera imagen.
  def show_first()
    show_move(GO_FIRST)
  end # show_first()

  # Muestra la anterior imagen.
  def show_previous(jump = false)
    if not jump
      return show_move(GO_PREVIOUS)
    else
      return show_move(GO_PREVIOUS_JUMP)
    end
  end # show_previous()

  # Muetra la siguiente imagen.
  def show_next(jump = false)
    if not jump
      return show_move(GO_NEXT)
    else
      return show_move(GO_NEXT_JUMP)
    end
  end # show_next()

  # Muestra la última imagen.
  def show_last()
    return show_move(GO_LAST)
  end # show_last()

  # Muestra la imagen pasada como parámetro.
  def show_image(new_image = '')

    if (new_image.to_s == '')

      # Si no se indica imagen se usa la primera de la lista.
      if (@images.length == 0)
        WM.error_message(WM.get_text(MESSAGE_WARNING_NO_IMAGES))
        return false
      end
      new_image_index = 0
      new_image = @images[new_image_index]

    else # (new_image == '')

      # Buscamos el elemento en el array de imágenes.
      if is_number(new_image)
        # Hemos mandado el índice.
        new_image_index = new_image
        new_image = @images[new_image_index].to_s
      else # is_number(new_image)
        # Hemos mandado el nombre del fichero.
        new_image_index = @images.index(new_image)
      end # is_number(new_image)

      if (new_image.empty?)
        WM.error_message(WM.get_text(MESSAGE_WARNING_NO_MORE_IMAGES_TO_DISPLAY))
        return false
      end # (new_image_index.nil? or with_image.empty?)

      if (new_image_index.nil? or new_image.empty?)
        WM.error_message(WM.get_text(MESSAGE_ERROR_IMAGE_CANT_LOCATE % [new_image]))
        return false
      end # (new_image_index.nil? or with_image.empty?)

    end # (new_image == '')

    if not File.exists?new_image
      # Borramos el fichero del array para que no vuelva a aparecer.
      @images.delete_at(new_image_index)
      WM.error_message(WM.get_text(MESSAGE_ERROR_IMAGE_DONT_EXISTS % [new_image]))
      return false
    end

    if not is_valid_extension(new_image)
      # Borramos el fichero del array para que no vuelva a aparecer.
      @images.delete_at(new_image_index)
      WM.error_message(WM.get_text(MESSAGE_ERROR_FORMAT_NOT_SUPPORTED % [new_image]))
      return false
    end

    if (File.extname(new_image).downcase == '.gif')
        # Tratamos los gifs.
        video = Qt::Movie.new(new_image)
        video.start()
        @image_width = video.currentPixmap().width
        @image_height = video.currentPixmap().height
        video.stop()
        if ((@image_width == 0) or (@image_heigh == 0))
            @images.delete_at(new_image_index)
            WM.error_message(WM.get_text(MESSAGE_ERROR_FILE_LOAD_FAILS % [new_image]))
            return false
        end # ((@image_width == 0) or (@image_heigh == 0))
        @image_file = new_image
        $options.url = @image_file # Mejorar esto con un método de acceso a @image_file.
        @angle = 0

        @viewer.setMovie(video)
        @viewer.movie.start()
    else
        if EXIFR_AVAILABLE

            # Value 0th Row     0th Column
            # 1     top         left side
            # 2     top         right side
            # 3     bottom      right side
            # 4     bottom      left side
            # 5     left side   top
            # 6     right side  top
            # 7     right side  bottom
            # 8     left side   bottom

            # 1        2       3      4         5            6           7          8

            # 888888  888888      88  88      8888888888  88                  88  8888888888
            # 88          88      88  88      88  88      88  88          88  88      88  88
            # 8888      8888    8888  8888    88          8888888888  8888888888          88
            # 88          88      88  88
            # 88          88  888888  888888

            begin
                orientation = EXIFR::JPEG.new(new_image).orientation.to_i
            rescue
                orientation = 0
            end

            if (orientation == 1)
                new_angle = 0

            elsif (orientation == 2)
                new_angle = 0

            elsif (orientation == 3)
                new_angle = 180

            elsif (orientation == 4)
                new_angle = 180

            elsif (orientation == 5)
                new_angle = 90

            elsif (orientation == 6)
                new_angle = 90

            elsif (orientation == 7)
                new_angle = -90

            elsif (orientation == 8)
                new_angle = -90

            else
                new_angle = 0
            end

        else
            new_angle = 0
        end

        # OJO: consumo inexperado de memoria.
        #  En la documentación que hay en http://developer.kde.org comentan esta
        # situación e informan del metodo dispose.
        #  Por lo que parece, si no se usa pueden quedar referencias a esa memoria
        # que impidan que el garbage collector la libere.
        #@viewer.setPixmap(Qt::Pixmap.fromImage(Qt::Image.new(new_image)))
        #@viewer.setPixmap(Qt::Pixmap.fromImage(image))
        image = Qt::Image.new(new_image)

        if (new_angle > 0)
            transform_matrix = Qt::Transform.new()
            transform_matrix.rotate(new_angle)
            image = image.transformed(transform_matrix)
        end

        @image_width = image.width
        @image_height = image.height
        if ((@image_width == 0) or (@image_heigh == 0))
            @images.delete_at(new_image_index)
            WM.error_message(WM.get_text(MESSAGE_ERROR_FILE_LOAD_FAILS % [new_image]))
            return false
        end # ((@image_width == 0) or (@image_heigh == 0))
        @image_file = new_image
        $options.url = @image_file # Mejorar esto con un método de acceso a @image_file.
        @angle = 0

        self.setUpdatesEnabled(false)

        pixmap = Qt::Pixmap.fromImage(image)
        @viewer.setPixmap(pixmap)
        # Evitamos que el programa coma memoria según se van cargando imágenes.
        pixmap.dispose()
        image.dispose()
    end

    @curr_image_index = new_image_index

    # Forzamos el refresco en la llamada a zoom() porque cambiamos la imagen.
    if @auto_resize
      zoom(ZOOM_AUTOFIT, true)
    else # @auto_resize
      zoom(ZOOM_NO, true)
    end # @auto_resize

    # Zoom() ya se encarga de poner el caption de la form.
    #set_caption()

    self.setUpdatesEnabled(true)

    return true

  end # show_image(new_image = '')

  # Encuentra ficheros visualizables en el directorio indicado.
  def find_files(url = './')

    if File.directory?(url)
      @curr_dir = File.expand_path(url) + '/'
    else
      directory = File.dirname(url)
      if directory.empty?
        directory = '.'
      end

      @curr_dir = File.expand_path(directory) + '/'
    end;

    if not File.directory?@curr_dir
      return -1
    end
    #mask = '%s/*.{%s %s}' % [@curr_dir, $options.valid_extensions.downcase,
    #                          $options.valid_extensions.upcase]
    #@images = Dir.glob(mask)
    @images = Array.new()
    Dir.entries(@curr_dir).each() do |entry|
      # Ojo, index devuelve nil en ocasiones.
      if not File.directory?@curr_dir+entry
        if File.basename(entry)[0] != "."[0]
          if File.extname(entry).empty? or (@valid_extensions.index(File.extname(entry).downcase + ' ').to_i > 0)
            if MIMEMAGIC_AVAILABLE
              #add_image = MimeMagic.by_path(@curr_dir + entry).start_with?('image/')
              add_image = MimeMagic.by_magic(File.open(@curr_dir + entry)).to_s.start_with?('image/')
            else
              add_image = true
            end
            if add_image
              @images << '%s%s' % [@curr_dir, entry]
            end
          end
        end
      end
    end

    if not File.directory?url and (@images.index(url) == nil)
        @images << '%s%s' % [@curr_dir, File.basename(url)]
    end

    @images.sort_by!{|sort_url| sort_url.downcase}
    $options._p_random_mode = false
    return @images.empty? ? 0 : @images.length
  end # find_files(directory = './')

  # Muestra una imagen.
  def load_image(url = '')

    if (url.nil? or url.empty?)
      return false
    end

    tmp_url = url.downcase()
    @valid_protocols.each() do |item|
      if (tmp_url.downcase.index(item[0]) == 0)
        if (item[1].eql?PROTOCOL_HTTP or item[1].eql?PROTOCOL_HTTPS or
              item[1].eql?PROTOCOL_FTP)
          # Descargamos la imagen a temporal.
          tmp_url = '%s/%s' % [TMP_DIR, File.basename(url)]
          if (File.exists?tmp_url)
            File.delete(tmp_url)
          end
          system('wget -O "%s" "%s"' % [tmp_url, url])
          url = tmp_url
        elsif item[1].eql?PROTOCOL_FILE
          # Eliminamos el protocolo ya que sobra.
          url = url.sub(item[0], '')
        else
          # No se hace nada.
        end
      end
    end

    url = File.expand_path(url)
    if File.directory?(url)
      directory_name = url
      file_name = ''
      num_files = find_files(directory_name)
    else
      directory_name = File.dirname(url)
      file_name = directory_name + '/' + File.basename(url)
      num_files = find_files(file_name)
    end

    if num_files == 0
      WM.error_message(WM.get_text(MESSAGE_WARNING_NO_IMAGES_IN_DIR % [directory_name]))
    elsif num_files == -1
      WM.error_message(WM.get_text(MESSAGE_WARNING_DIRECTORY_DOES_NOT_EXISTS % [directory_name]))
    elsif file_name.empty?
      file_name = @images[0]
    end

    if not File.exists?file_name
      WM.error_message(WM.get_text(MESSAGE_ERROR_IMAGE_CANT_LOCATE % [file_name]))
      num_files = -1
    end

    if num_files <= 0
      directory_name = ENV['HOME']
      default_jpg = directory_name + "/.slideviewer_default.jpg"
      if not File.exists?default_jpg
        return false
      else
        file_name = default_jpg
        @images = Array.new()
        @images << file_name
      end
    end

    # Solucionamos el salto de imágenes al haber un error.
    if not show_image(file_name)
      #Vamos a intentar que pase a la siguiente.
      #@curr_image_index = -1
      return false
    else
      return true
    end

  end # load_image

  # Abre una imagen o bien un directorio.
  def open_file()

    if @image_file.to_s.empty?
      start_dir = ENV['HOME']
    else
      start_dir = File.dirname(@image_file)
    end
    command = "kdialog --title '%s - %s' --getopenfilename '%s' '%s'" %
                [PROGRAM_NAME, MESSAGE_KDIALOG_OPEN, start_dir,
                  '*.' + @valid_extensions.strip.gsub('.', ' *.')]
    result = ''
    IO.popen(command, "r") do |pipe|
      result = pipe.read
    end
    result.chomp!
    if (result != '')
      $options._p_random_mode = false
      # Solucionamos el salto de imágenes al haber un error.
      return load_image(result)
    else
      return false
    end # (result != '')

  end # open_file()

  def timerEvent(event)
    if (event.timerId() == @timer.timerId())
      if ((@slideshow_mode & SLIDESHOW_PAUSED) == 0)
        if (@slideshow_mode == SLIDESHOW_SECUENTIAL)
          show_next()
        else # (@slideshow_mode == SLIDESHOW_SECUENTIAL)
          setCursor(Qt::Cursor.new(Qt::WaitCursor))
          new_image_index = rand(@images.length).to_i
          # Solucionamos el salto de imágenes al haber un error.
          if not show_image(new_image_index)
            #@curr_image_index = -1
          end
          unsetCursor()
        end # (@slideshow_mode == SLIDESHOW_SECUENTIAL)
      end # ((@slideshow_mode & SLIDESHOW_PAUSED) == 0)
    else # (event.timerId() == @timer.timerId())
      super()
    end #~(event.timerId() == @timer.timerId())
  end # timerEvent()

  def slideshow(mode = SLIDESHOW_STOP)
    if !(!@timer.isActive and (mode == SLIDESHOW_STOP))
      if @timer.isActive
        @timer.stop()
      elsif
        @timer.start($options.slideshow_seconds*1000, self)
        if (mode == SLIDESHOW_STOP)
          mode = SLIDESHOW_SECUENTIAL
        end
      end
    end

    @slideshow_mode = mode
    set_caption()
  end # slideshow

  def view_copy

    if @image_file.empty?
      return false
    end

    WM.add_window(@image_file)

  end # view_copy

  def delete_image
    curr_image = @images[@curr_image_index].to_s
    if File.exists?curr_image
      # Borramos el fichero y luego lo eliminamos del array.
      if system( "kioclient move '%s' trash:/" % [curr_image])
        @images.delete_at(@curr_image_index)
        show_move(GO_CURRENT)
      end
    end
  end # delete_image


  def get_layout
    #NOTA: por algún motivo comenté lo de visible pero
    # entonces al grabar el layout se grababa todo.
    if visible()
      zoom = '%s' % [@zoom_level]
      zoom = zoom.gsub(',', '.')
      return '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s' %
                [self.x(), self.y(), self.width(), self.height(), zoom,
                  @viewer.x(),
                  @viewer.y(),
                  @scrollarea.horizontalScrollBar.value(),
                  @scrollarea.verticalScrollBar.value(),
                  @frameless ? 1 : 0, @image_file]
    else
      return ''
    end
  end # get_layout

  def set_layout(awindow_layout = nil)

    if awindow_layout.nil?
      return false
    end

    new_frameless = (awindow_layout[9].to_i == 0) ? false : true
    if new_frameless
      # Por defecto la form tiene frame. False para que no llame a show().
      frameless_toggle(false)
    end
    zoom(awindow_layout[4].to_f)

    if new_frameless
      new_x = awindow_layout[0].to_i
      new_y = awindow_layout[1].to_i
    else
      # Hay que desplazar teniendo en cuent el window frame.
      new_x = awindow_layout[0].to_i + $options.window_desktop_width_adjust
      new_y = awindow_layout[1].to_i + $options.window_desktop_height_adjust
    end
    new_width = awindow_layout[2].to_i
    hew_height = awindow_layout[3].to_i
    self.setGeometry(new_x, new_y, new_width, hew_height)
    # No hay manera de que esto funcione aquí. Pasado el código
    # al método layout_load para que se haga después del show().
    #@viewer.move(awindow_layout[5].to_i, awindow_layout[6].to_i)

    return true

  end # set_layout

  def scrollarea_move(new_h = 0, new_v = 0, new_x = 0, new_y = 0)
    #@viewer.move(new_x, new_y)
    @scrollarea.move_to(new_h, new_v)
  end

  def frameless_toggle(do_show = true)
    if ((windowFlags & Qt::FramelessWindowHint.to_i) > 0)
      setWindowFlags(windowFlags - Qt::FramelessWindowHint)
      @frameless = false
    else
      setWindowFlags(windowFlags + Qt::FramelessWindowHint)
      @frameless = true
    end
    if do_show
      show()
    end
  end # frameless_toggle

  def fullscreen_toggle()
    if isFullScreen()
      showNormal()
      @fullscreen = false
    else
      showFullScreen()
      @fullscreen = true
    end
    zoom(ZOOM_AUTOFIT)
  end

  def is_valid_extension(file_name = '')

    if file_name.empty?
      return false
    end

    extension = File.extname(file_name).downcase
    if extension.empty?
      return true
    end

    return !@valid_extensions.scan(' ' + File.extname(file_name).downcase + ' ').empty?

  end # is_valid_extension(file_name = '')

  def is_number(variable)
    return (variable.to_i.to_s.eql?variable.to_s.strip)
  end
  
  def help
    command = "kdialog --title '%s - %s' --msgbox '%s'" %
                [PROGRAM_NAME, MESSAGE_HELP, MESSAGE_HELP_SHORTCUTS_HTML]
    result = ''
    IO.popen(command, "r") do |pipe|
      result = pipe.read
    end
  end

  def rename_image(file_name = '')
    directory = File.dirname(file_name)
    if directory.empty?
      directory = './'
    end
    @curr_dir = File.expand_path(directory) + '/'
    if not File.directory?@curr_dir
        return False
    end

    old_file_name = File.basename(file_name)

    command = 'kdialog --title "%s" --inputbox "%s" "%s"' %
                [PROGRAM_NAME, MESSAGE_KDIALOG_RENAME_FILE,
                  old_file_name]
    new_file_name = ''
    IO.popen(command , "r") do |pipe|
      new_file_name = pipe.read
    end
    new_file_name.chomp!
    if !(new_file_name == '') and (new_file_name != old_file_name)
      # Rename file.
      new_file_name = directory + '/' + new_file_name
      File.rename(file_name, new_file_name)
      load_image(new_file_name)
    end
  end

end # RIVViewWindow < Qt::MainWindow


#
# Lector/creador/parseador de la configuración.
#
# Ojo, llamarlo tras parsear parámetros para determinar que cfg leer.
class RIVCfg

  def self.read(options)

    if (options.cfg_file == '')
      options.cfg_file = PROGRAM_CFG
    end # (options.cfg_file == '')

    if !File.exist?(options.cfg_file)
      return options
    end

    # Inicializamos el array donde se guardarán la configuración.
    config = {}

    File.foreach(options.cfg_file) do |line|

      line.strip!

      # Quitamos comentarios y espacios en blanco.
      if (line[0] != ?# and line =~ /\S/ )
        ipos = line.index('=')
        if (ipos)
          config[line[0..ipos - 1].strip] = line[ipos + 1..-1].strip
        else # (ipos)
          config[line] = ''
        end # (ipos)
      end # (line[0] != ?# and line =~ /\S/ )

    end # File.foreach(options.cfg_file) do |line|

    # Asignar valores.
    config.each do |key, value|

      puts(key)
      puts(value)

      if (key == 'url')
        if ((options.url == '') or (options.url == nil))
          eval('options.' + key + " = " + value)
        end # ((options.url == '') or (options.url == nil))
      elsif (key == 'zoom_factor')
        options.zoom_factor = 0.1
      elsif (key == 'zoom_maximum')
        options.zoom_maximum = 4
      elsif (key == 'zoom_minimum')
        options.zoom_minimum = 0.1
      elsif (key[0,7] == 'layout_')
        # Layouts.
        eval('options.' + key + " = " + value)
        if (key.count('_') == 1)
          options._p_layouts += key + ' '
        end
      elsif ((key <=> 'zoop_minimum') == 1)
        # Ignoramos este valor.
      elsif (key[0,3] == '_p_')
        # Ignoramos este valor.
      elsif (key.eql?"window_border_size")
        # Ignoramos este valor.
      else #  (key == 'url')
        if not value.empty?
          eval('options.' + key + " = " + value)
          if (key.eql?'valid_extensions')
            # Eliminamos los espacios en blanco que puede haber añadido el usuario.
            options.valid_extensions = options.valid_extensions.gsub(' ', '')
          end
        end
      end # (key == 'url')

    end # config.each do |key, value|

    # Traslado del fichero de configuración.
    if ((options.version.to_f == 0) or (options.version.to_f == 0.4) or
          (options.version.to_f == 0.5) or (options.version.to_f == 0.6) or
          (options.version.to_f == 0.7) or (options.version.to_f == 0.8))

      if (options.zoom_factor.to_f == 0.2)
        options.zoom_factor = 0.1
      end
      if (options.window_desktop_height_adjust.to_i == 13)
        options.window_desktop_height_adjust = 28
      end
      if (options.window_desktop_width_adjust.to_i == 27)
        options.window_desktop_width_adjust = 8
      end

      if (options.key_rotate_left == Qt::ControlModifier + Qt::Key_L)
        options.key_rotate_left = Qt::ControlModifier + Qt::Key_Minus
      end

      if (options.key_rotate_right == Qt::ControlModifier + Qt::Key_R)
        options.key_rotate_right = Qt::ControlModifier + Qt::Key_Plus
      end

      # Esta propiedad está obsoleta.
      begin
        options.delete_field('key_slideshow')

      rescue
         # Ignoramos.
      end

      options.version = PROGRAM_VERSION
      show(options, true)

      # nada.
    end #  (options.version.to_f == 0)

    #options.window_desktop_height_adjust = QApplication::style().pixelMetric(QStyle::PM_TitleBarHeight)
    #put options.window_desktop_height_adjust

    return options

  end # self.read(file = '')

  def self.show(options, write_cfg = false)

    acfg = Array.new

    options.url = options.url.gsub(",", "&#44;")
    options.marshal_dump.each do |k,v|
      if not ((k[0,3].eql?'_p_') or (k[0,8].eql?'cfg_file'))
        #acfg += [str.gsub('#<OpenStruct', '').strip.chomp(',').chomp('>').gsub('=', ' = ')]
        key = k.to_s
        if key[0,6].eql?'layout' or key.eql?'url' or key.eql?'valid_extensions' or key.eql?'version'
            #acfg += [key + ' = "' + v.gsub(/\n/, '|') + '"'] # There is \n characters.
            acfg += [key + ' = "' + v.to_s + '"'] # There is \n characters.
        else
            acfg += ["#{k} = #{v}"]
        end
      end

    end # options.marshal_dump.each do |k,v|

    acfg.sort!

    if write_cfg
      f=File.new(options.cfg_file,'w')
      f.puts "# #{PROGRAM_TITLE}\n"
      f.puts "#\n# Configuration file\n# ------------------\n"
    else
      puts "# #{PROGRAM_TITLE}\n"
      puts "#\n# Configuration file\n# ------------------\n"
    end

    acfg.each do |str|

      if ((str <=> 'zoop_minimum') == 1)
        next
      end

      if ((str <=> 'zoom_minimun') == 1)
        next
      end

      if ((str <=> 'zoom_') == 1)
        str.gsub!(',', '.')
      end

      if ((str <=> 'url') == 1)
        str.gsub!('&#44;', ',')
      end

      if write_cfg
        puts str
        f.puts str
      else
        puts str
      end
    end # acfg.each

    if write_cfg
      f.close
    else
      puts "\n"
    end

  end # self.show(options)

end # RIVCfg


#
# Una OptionParser especializada.
#
# Nota: código sacado de la documentaicón de ruby.
#
class RIVOptionParser

  CODES = %w[iso-2022-jp shift_jis euc-jp utf8 binary]
  CODE_ALIASES = { "jis" => "iso-2022-jp", "sjis" => "shift_jis" }

  #
  # Return a structure describing the options.
  #
  def self.parse(args)

    # Aquí almacenamos las distintas opciones.
    options = OpenStruct.new

    # Estados.
    options._p_frameless = false
    options._p_layouts = ''
    options._p_print_cfg = false
    options._p_random_mode = false
    options._p_show_layout = nil
    options._p_write_cfg = false

    # Otras opciones.
    options.auto_resize = true
    options.cfg_file = PROGRAM_CFG
    options.layouts = ''
    options.move_jump_size = 10
    options.scroll_bars_policy = Qt::ScrollBarAlwaysOff # Qt::ScrollBarAsNeeded, Qt::ScrollBarAlwaysOn
    options.show_in_caption_dir = false
    options.show_in_caption_index = true
    options.show_in_caption_dimensions = false
    options.show_in_caption_zoom = true
    options.slideshow_seconds = 5
    options.url = ''
    options.valid_extensions = 'bmp,gif,jpg,jpeg,png,pbm,pgm,ppm,tiff,webp,xpm,xbm' # Extraido de la documentación de Qt::QImage.
    options.version = 0
    options.zoom_factor = 0.10
    options.zoom_maximum = 4
    options.zoom_minimum = 0.10

    # Windows decoration.
    options.window_desktop_width_adjust = 8
    options.window_desktop_height_adjust = 28

    # Hot keys.
    options.key_chrome = Qt::ControlModifier + Qt::Key_C # Ctrl+C.
    options.key_copy = Qt::Key_C # C.
    options.key_delete = Qt::Key_Delete # Del.
    options.key_insert = Qt::Key_Insert # Insert.
    options.key_rename = Qt::Key_F2 # F2.
    options.key_help = Qt::Key_H #H.
    options.key_frameless_toggle = Qt::Key_F # F.
    options.key_filemanager = Qt::ControlModifier + Qt::Key_F # Ctrl+F.
    options.key_first = Qt::Key_Home # 16777232 # Home.
    options.key_fullscreen_toggle = Qt::Key_F11 # F11.
    options.key_krita = Qt::ControlModifier + Qt::Key_K # Ctrl+K.
    options.key_last = Qt::Key_End # 16777233 # End.
    options.key_next = Qt::Key_Space # 32 # Space.
    options.key_next_jump = Qt::ControlModifier + Qt::Key_Space # Ctrl+Space.
    options.key_previous = Qt::Key_Backspace # 16777219 # Backspace.
    options.key_previous_jump = Qt::ControlModifier + Qt::Key_Backspace # Ctrl+Backspace.
    options.key_open = Qt::ControlModifier + Qt::Key_O # Ctrl+O
    options.key_quit = Qt::Key_Escape # Ctrl+Q.
    options.key_rotate_left = Qt::ControlModifier + Qt::Key_Minus # Ctrl+-
    options.key_rotate_right = Qt::ControlModifier + Qt::Key_Plus # Ctrl++.
    options.key_layout_clear = Qt::ControlModifier + Qt::Key_E # E.
    options.key_layout_delete = Qt::Key_E # E.
    options.key_layout_load = Qt::Key_L # L.
    options.key_layout_overwrite = Qt::ControlModifier + Qt::Key_S # S.
    options.key_layout_save = Qt::Key_S # S.
    options.key_showphoto = Qt::ControlModifier + Qt::Key_D #. Ctrl+D
    options.key_slideshow_pause = Qt::Key_P # P.
    options.key_slideshow_random = Qt::ControlModifier + Qt::Key_R # Ctrl+R.
    options.key_slideshow_secuential = Qt::ControlModifier + Qt::Key_W # Ctrl+W.
    options.key_zoomin = Qt::Key_Plus # +
    options.key_zoomout = Qt::Key_Minus # -
    options.key_zoomrestore = Qt::Key_O # O

    op = OptionParser.new do |opts|

      opts.banner = MESSAGE_COMMAND_BANNER % [PROGRAM_TITLE, PROGRAM_AUTHOR, PROGRAM_EMAIL, PROGRAM_FILE_NAME]

      opts.separator ""
      opts.separator MESSAGE_COMMAND_SPECIFIC

      opts.on('-c', "--cfg FILE", MESSAGE_COMMAND_C % [PROGRAM_CFG]) do |cfg|
        options.cfg_file = cfg
      end

      opts.on('-w', "--write_cfg [FILE]", MESSAGE_COMMAND_W) do |cfg|
        if (cfg != nil)
          options.cfg_file = cfg
        end
        options._p_write_cfg = true
      end

      opts.on('-f', "--frameless", MESSAGE_COMMAND_F) do |cfg|
        options._p_frameless = true
      end

      opts.on('-p', "--print_cfg", MESSAGE_COMMAND_P) do |cfg|
        options._p_print_cfg = true
      end

      opts.on('-l', "--layout [LAYOUT]", MESSAGE_COMMAND_L) do |cfg|
        options._p_show_layout = cfg.nil? ? '' : cfg
      end


      opts.separator ""
      opts.separator MESSAGE_COMMAND_COMMON

      # La necesaria help.
      opts.on_tail("-h", "--help", MESSAGE_COMMAND_H) do
        puts opts
        puts "\n" + MESSAGE_HELP_SHORTCUTS        
        exit
      end

      # Y la versión con los créditos.
      opts.on_tail("-v", "--version", MESSAGE_COMMAND_V) do
        puts "#{PROGRAM_TITLE}, by #{PROGRAM_AUTHOR} (#{PROGRAM_EMAIL})"
        exit
      end

    end # opts = OptionParser.new do |opts|

    op.parse!(args)

    if ((options.url == '') or (options.url == nil))
      options.url = args[0]
    end
    return options

  end # self.parse(args)

end # class RIVOptionParser

class WindowManager

  attr_accessor :awindows
  attr_accessor :windows_count

  def initialize()
    @awindows = Array.new()
    @alayout = Array.new()
    @last_layout = ''
    @windows_count = 0
  end # initialize()

  def add_window(url = '', awindow_layout = nil)

    new_window = RIVViewWindow.new()

    if awindow_layout.nil?

      if (!url.nil? and !url.empty?)
          if not new_window.load_image(url)
            url = nil
          end
      end # (!url.nil? and !url.empty?)

      if (url.nil? or url.empty?)
          # No preguntar, salir directamente.
          exit
          #if not new_window.open_file()
          #  WM.error_message(WM.get_text("A file or directory is required.\n\nTry\n\n " +
          #              "#{PROGRAM_FILE_NAME} File \n\nor\n\n #{PROGRAM_FILE_NAME} Dir"))
          #  exit
          #end # not new_window.open_file()
      end # (url.nil? or url.empty?)

      new_window.show()

    else # awindow_layout.nil?

      if not new_window.load_image(url)
        exit
      end
      # No hay manera de que esto funcione en set_layout así que lo
      # tengo que hacer aquí. Si no desactivo los updates tampoco funciona.
      # al método layout_load para que se haga después del show().
      new_window.setUpdatesEnabled(false)
      new_window.set_layout(awindow_layout)
      new_window.show()
      new_window.scrollarea_move(awindow_layout[7].to_i, awindow_layout[8].to_i,
                                  awindow_layout[5].to_i, awindow_layout[6].to_i)
      new_window.setUpdatesEnabled(true)

    end # awindow_layout.nil?

    @awindows << [@windows_count.nil? ? 0 : @windows_count + 1, new_window]
    @windows_count = @awindows.length

  end

  def remove_window()

  end

  def window_to_top(window = nil)

    if window.nil?
      return false
    end

    @awindows.each do |row|
      if (window == row[1])
        row[0] = @awindows.length
      else
        row[0] -= 1
      end
    end # @awindows.each do |window|

  end #window_to_top(window = nil)

  def layout_save(layout_property = '', layout_name = '')

    if layout_property.empty?

      command = 'kdialog --title "%s" --inputbox "%s" "%s"' %
                  [PROGRAM_NAME, MESSAGE_KDIALOG_LAYOUT_TITLE,
                    MESSAGE_KDIALOG_LAYOUT_NAME]
      IO.popen(command , "r") do |pipe|
        layout_name = pipe.read
      end
      layout_name.chomp!
      if (layout_name == '')
        return false
      end

    end # layout_name.empty?

    @alayout.clear()
    @awindows = @awindows.sort_by {|element| element[0]}
    @awindows.each do |window|
      layout = window[1].get_layout()
      puts "=============================================="
      puts layout
      puts "=============================================="
      if !layout.empty?
        @alayout << layout
      end
    end # @awindows.each do |window|

    if !@alayout.empty?

      if layout_property.empty?

        # Buscamos donde grabar.
        layout_i = 0
        layout_value = ''
        while !layout_value.nil? do
          begin
            layout_i += 1
            eval('layout_value = $options.layout_%s' % [layout_i.to_s.rjust(3, "0")])
          rescue
            layout_value = nil
          end
        end # while layout.nil? do

        layout_property = 'layout_%s' % [layout_i.to_s.rjust(3, "0")]

      end #  layout_property.empty?

#       layout_value = '%s|' % [layout_name]
#       @alayout.each {|record| layout_value += record + '|'}
#       begin
#         puts '--------------------------------------------------------------'
#         puts layout_value
#         puts '--------------------------------------------------------------'
#         eval('$options.%s = layout_value' % [layout_property])
#       rescue
#         WM.error_message(WM.get_text(MESSAGE_ERROR_LAYOUT_INVALID_NAME) %
#                           [layout_name])
#         return false
#       end
#
      eval('$options.%s = layout_name' % [layout_property])
      path = ''
      base_path = ''
      image_number = 0
      @alayout.each() do |record|
        image_number += 1
        window_layout = record.chomp.split(',')
        image_prop = ''
        image_name = ''
        window_layout.each_with_index do |value, index|
          if (index < 10)
            image_prop += value + ','
          elsif (index == 10)
            image_name = value
          end
        end
        if path.empty?
          path = File.dirname(image_name)
          base_path = Pathname.new(path)
        end
        image_name = Pathname.new(image_name).relative_path_from(base_path).to_s

        eval('$options.%s_image_%s_prop = image_prop' % [layout_property, image_number.to_s.rjust(3, "0")])
        eval('$options.%s_image_%s_name = image_name' % [layout_property, image_number.to_s.rjust(3, "0")])
      end
      eval('$options.%s_path = path' % [layout_property])
      eval('$options.%s_count = image_number' % [layout_property])

      $options._p_layouts = $options._p_layouts.gsub(layout_property, '')
      $options._p_layouts += layout_property + ' '

      RIVCfg.show($options, true)

      @last_layout = layout_name

    end # !@alayout.empty?

  end # layout_save()

  def layout_overwrite

    layout_property, layout_name = read_layouts()
    if layout_name.empty?
      return false
    end

    layout_save(layout_property, layout_name)

  end # layout_overwrite

  def read_layouts(layout_name = '')

    if ($options._p_layouts.nil? or $options._p_layouts.empty?)
      return ''
    end

    layout_name.strip!
    layout_property = ''
    default = @last_layout
    command = 'kdialog --title "%s" --menu "%s" ' %
                  [PROGRAM_NAME, MESSAGE_KDIALOG_LAYOUT_SELECT]
    if (default != '')
      command += '--default "%s" ' % default
    end
    alayouts_variables = $options._p_layouts.chomp.split(' ')
    alayouts = Array.new()
    alayouts_variables.each do |element|
      alayout = eval('$options.%s' % [element]).chomp.split('|')
      if !alayout.empty?
        alayouts << [element, alayout[0]]
        if alayout[0].upcase.eql?layout_name.upcase
          layout_property = element
        end
      end
    end # alayouts_variables.each do |element|

    if layout_property.empty?

      if !layout_name.empty?
        WM.error_message(WM.get_text(MESSAGE_ERROR_LAYOUT_NOT_FOUND) % [layout_name])
      end

      # Ordenamos por el nombre de layout.
      alayouts = alayouts.sort_by {|element| element[1]}

      layouts = ''
      alayouts.each {|element| layouts += '"%s" "%s" ' % [element[0], element[1]]}
      IO.popen(command + layouts, "r") do |pipe|
        layout_property = pipe.read
      end

      layout_property.chomp!
      # Obtenemos el nombre del layout.
      alayouts.each do |row|
        if row[0].eql?layout_property
          layout_name = row[1]
          break
        end
      end # alayouts.each do |row|

    end # layout_property.empty?

    return layout_property, layout_name

  end #read_layouts()

  def layout_load(layout_name = '')

    layout_property, layout_name = read_layouts(layout_name)

    if layout_property.empty?
      return false
    end

    @alayout.clear()
    begin
      eval('layout = $options.%s' % [layout_property])
    rescue
      layout = ''
    end

    path = ''
    count = 0
    begin
      eval('path = $options.%s_path' % [layout_property])
      eval('count = $options.%s_count' % [layout_property])
    rescue
      path = ''
      count = 0
    end

    if (layout.nil? or layout.empty?)
      WM.error_message(WM.get_text(MESSAGE_ERROR_LAYOUT_NOT_FOUND) % [layout_property])
      return false
    end

    if (path.nil?)
      @alayout.concat(layout.split('|'))
    else
      (1..count.to_i).each do |idx|
        begin
          eval('image_name = $options.%s_image_%s_name' % [layout_property, idx.to_s.rjust(3, "0")])
          eval('image_prop = $options.%s_image_%s_prop' % [layout_property, idx.to_s.rjust(3, "0")])
        rescue
          image_name = ''
          image_prop = ''
        end
        image_name = Pathname.new(path + '/' + image_name).realpath.to_s
        layout += '|' + image_prop + image_name
      end
      @alayout.concat(layout.split('|'))
    end

    # Cerramos todas las ventanas.
    @awindows.each {|window| window[1].close}
    @awindows.clear()

    @alayout.each do |window_layout|

      if !window_layout.empty?

        awindow_layout = window_layout.chomp.split(',')
        image_file = awindow_layout[10]

        if !image_file.nil?
          # Si es nil se trata del primer elemento del array que contiene el nombre del layout.
          add_window(image_file, awindow_layout)
        end

      end # !window_layout.emtpy?

    end # @alayout.each do |window_layout|

    @last_layout = layout_name

    return true

  end # layout_load()

  def layout_delete()

    layout_current = read_layouts()
    if layout_current[0].empty?
      return false
    end

    $options.to_h.each do |key, value|
      if key.to_s.start_with?(layout_current[0])
        $options.delete_field(key.to_s)
      end
    end

    $options._p_layouts = $options._p_layouts.gsub(layout_current[0], '')
    RIVCfg.show($options, true)

  end # layout_delete()

  def layout_clear()

    # Cerramos todas las ventanas menos la primera.
    if !@awindows.empty?
      dummy = @awindows[0][1]
      @awindows.delete_at(0)
      @awindows.each {|window| window[1].close}
      @awindows.clear()
      @windows_count = 0
      @awindows << [@windows_count.nil? ? 0 : @windows_count + 1, dummy]
    end # !@awindows.empty?

  end # layout_clear()

  def error_message(message = '')
    puts message
    mb = Qt::MessageBox.new(Qt::MessageBox::Warning, PROGRAM_TITLE, message)
    mb.exec()
  end # error_message(message = '')

  def get_text(text = '', language = 0)
    return text
  end # get_text(text = '', language = 0)

end # class WindowManager

# Parseamos los parámetros.
$options = RIVCfg.read(RIVOptionParser.parse(ARGV))

if ($options._p_print_cfg or $options._p_write_cfg)
  RIVCfg.show($options, $options._p_write_cfg)
  exit
end # ($options._p_print_cfg)

# Creamos la aplicación.
APP = Qt::Application.new(ARGV)

WM = WindowManager.new()

if $options._p_show_layout.nil?
  if not WM.add_window($options.url)
    exit
  end
else
  if not WM.layout_load($options._p_show_layout)
    exit
  end
end

# La ejecutamos.
APP.exec()

# Grabamos la configuracion antes de salir.
RIVCfg.show($options, true)
